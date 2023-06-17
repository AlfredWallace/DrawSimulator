//
//  Draws.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 17/04/2023.
//

import CoreData
import Foundation
import SwiftUI

@MainActor class Draws: ObservableObject {
    
    static let numberOfDraws = 1000
    
    @Published private(set) var isRunning = false
    @Published private(set) var progress = 0.0
    
    private(set) var task: Task<Void, Never>? = nil
    private let coreDataController: CoreDataController
    private var winYear: Int16 = 1970
    
    init(coreDataController: CoreDataController) {
        self.coreDataController = coreDataController
    }
    
    private struct DrawTeam: Equatable {
        let poolName: String
        let team: Team
        let country: Country
    }
    
    private struct InnerLoopPairing {
        let seededTeam: Team
        let unseededTeam: Team
    }
    
    private enum SeasonError: Error {
        case notExactlyOne(winYear: Int)
    }
    
    private func extractOneTeam(_ teams: inout [DrawTeam]) -> DrawTeam {
        let length = teams.count
        return teams.remove(at: Int.random(in: 0..<length))
    }
    
    func cancelDraw() {
        isRunning = false
    }
    
    func draw(for winYear: Int16, _ times: Int = numberOfDraws) {
        isRunning = true
        progress = 0.0
        
        task = Task {
            
            self.winYear = winYear
            let season = getSeason()
            
            deleteDraws(for: season)
            
            // we will always pick a seeded team then pair it with an unseeded team (UEFA rule): this eliminates some complexity of the algorithm
            // todo : optimiser pour pas faire 2 requêtes à chaque boucle
            let seededDrawTeams = getDrawTeams(for: season, seeded: true)
            let unseededDrawTeams = getDrawTeams(for: season, seeded: false)
            
            outerLoop: for _ in 0..<times {
            
                if isRunning == false {
                    if let task {
                        task.cancel()
                    }
                }
                
                // optimization: we use copy for every iteration so that getDrawTeams is not called everytime
                var seededDrawTeamsCopy = seededDrawTeams
                var unseededDrawTeamsCopy = unseededDrawTeams

                await MainActor.run {
                    self.progress += 1.0
                }

                var innerLoopPairings = [InnerLoopPairing]()
                
                innerLoop: while seededDrawTeamsCopy.isEmpty == false {
                    
                    let seededDrawTeam = self.extractOneTeam(&seededDrawTeamsCopy)
                    
                    //UEFA rules
                    var possibleOpponents = unseededDrawTeamsCopy.filter { opponent in
                        opponent.country != seededDrawTeam.country
                        && opponent.poolName != seededDrawTeam.poolName
                    }
                    
                    // If opponents is empty, it's an invalid draw, so we discard the entire draw
                    // (happens (rarely) when, at some point in the draw, the remaining teams are not compatible with the rules)
                    if possibleOpponents.isEmpty {
                        continue outerLoop
                    }
                    
                    let pickedOpponent = self.extractOneTeam(&possibleOpponents)
                    
                    unseededDrawTeamsCopy.removeAll { drawTeam in
                        drawTeam == pickedOpponent
                    }
                    
                    // in each draw, we are absolutely sure that there cannot be 2 pairings of the same teams
                    // because as soon as a team or its opponent is picked, we discard them from the arrays
                    // so: we can just add the current without checking if it exists first
                    innerLoopPairings.append(InnerLoopPairing(seededTeam: seededDrawTeam.team, unseededTeam: pickedOpponent.team))
                }
                
                // if the draw has been completed (thus is valid) we increase the count for all the matching pairings
                // we look for an existing pairing matching the current iteration
                // if there is one, we increase the count, otherwise we create the pairing
                for innerLoopPairing in innerLoopPairings {

                    coreDataController.performInBackgroundContextAndWait(commit: false) { moc in

                        let seededTeam = innerLoopPairing.seededTeam
                        let unseededTeam = innerLoopPairing.unseededTeam

                        let pairingsFetchRequest = NSFetchRequest<DrawPairing>(entityName: DrawPairing.entityName)
                        pairingsFetchRequest.predicate = NSPredicate(format: "season == %@ AND seededTeam == %@ AND unseededTeam == %@", season, seededTeam, unseededTeam)

                        do {
                            let pairingsResult = try moc.fetch(pairingsFetchRequest)

                            switch pairingsResult.count {
                                case 0:
                                    let _ = DrawPairing(context: moc, count: 1, season: season, seededTeam: seededTeam, unseededTeam: unseededTeam)
                                case 1:
                                    pairingsResult.first!.count += 1
                                default:
                                    fatalError("Database corrupted, there are several pairings with the same 2 teams (\(seededTeam.name), \(unseededTeam.name)) for a given season (\(season.winYear))")
                            }
                        } catch {
                            print("Failed to fetch or update pairings (\(seededTeam.name), \(unseededTeam.name)) for season: \(season.winYear)")
                        }
                    }
                }
                
                // reset for next outerLoop iteration
                innerLoopPairings = []
            }
            
            coreDataController.save()
            
            await MainActor.run {
                isRunning = false
            }
        }
    }
    
    // no need to batch delete here because there will be a fairly small amount of data every time, probably around 64
    private func deleteDraws(for season: Season) {
        
        coreDataController.performInBackgroundContextAndWait(commit: false) { moc in
            let pairingsFetchRequest = NSFetchRequest<DrawPairing>(entityName: DrawPairing.entityName)
            pairingsFetchRequest.predicate = NSPredicate(format: "season == %@", season)
            
            do {
                let result = try moc.fetch(pairingsFetchRequest)
                for pairing in result {
                    moc.delete(pairing)
                }
            } catch let error as NSError {
                print("Failed to fetch and delete pairings: \(error.localizedDescription)")
            }
        }
    }
    
    private func getSeason() -> Season {
        var seasons = [Season]()
        
        coreDataController.performInBackgroundContextAndWait(commit: false) { moc in
            let seasonRequest = NSFetchRequest<Season>(entityName: Season.entityName)
            seasonRequest.predicate = NSPredicate(format: "winYear == %@", winYear as NSNumber)
            
            do {
                seasons = try moc.fetch(seasonRequest)
            } catch {
                print("Failed to fetch the seasons: \(error.localizedDescription)")
            }
        }
        
        switch seasons.count {
            case 0:
                fatalError("There are no seasons with the winYear: \(winYear)")
            case 1:
                return seasons.first!
            default:
                fatalError("Database corrupted, there are several seasons with the winYear: \(winYear)")
        }
    }
    
    private func getDrawTeams(for season: Season, seeded: Bool) -> [DrawTeam] {
        var result = [DrawTeam]()

        coreDataController.performInBackgroundContextAndWait(commit: false) { moc in
            let seasonTeamsFetchRequest = NSFetchRequest<SeasonTeam>(entityName: SeasonTeam.entityName)
            seasonTeamsFetchRequest.predicate = NSPredicate(format: "season == %@ AND seeded == %@", season, seeded as NSNumber)

            do {
                let seasonTeams = try moc.fetch(seasonTeamsFetchRequest)
                result = seasonTeams.map {
                    DrawTeam(
                        poolName: $0.poolName,
                        team: $0.team!,
                        country: $0.team!.country!
                    )
                }

            } catch let error as NSError {
                print("Failed to fetch teams: \(error.localizedDescription)")
            }
        }

        return result
    }
}
