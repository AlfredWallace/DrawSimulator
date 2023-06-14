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
    
    private struct DrawTeam: Equatable {
        let poolName: String
        let team: Team
        let country: Country
    }
    
    private func extractOneTeam(_ teams: inout [DrawTeam]) -> DrawTeam {
        let length = teams.count
        return teams.remove(at: Int.random(in: 0..<length))
    }
    
    func cancelDraw() {
        isRunning = false
    }
    
    func draw(for season: Season, _ times: Int = numberOfDraws) {
        isRunning = true
        progress = 0.0
        
        task = Task {
            
            deleteDraws(for: season)
            
            outerLoop: for _ in 0..<times {
            
                if isRunning == false {
                    if let task {
                        task.cancel()
                    }
                }
                
                // we will always pick a seeded team then pair it with an unseeded team (UEFA rule): this eliminates some complexity of the algorithm
                var seededTeams = getTeams(for: season, seeded: true)
                var unseededTeams = getTeams(for: season, seeded: false)
//                var loopPairings = [(seededTeam: Team, unseededTeam: Team)]()
//
                await MainActor.run {
                    self.progress += 1.0
                }
            
                    
                while seededTeams.isEmpty == false {
                    
                    let seededTeam = self.extractOneTeam(&seededTeams)
                    
                    //UEFA rules
                    var opponents = unseededTeams.filter { opponent in
                        opponent.country != seededTeam.country
                        && opponent.poolName != seededTeam.poolName
                    }
                    
                    // If opponents is empty, it's an invalid draw, so we discard the entire draw
                    // (happens rarely, when at some point in the draw, the remaining teams are not compatible with the rules)
                    if opponents.isEmpty {
                        continue outerLoop
                    }
                    
                    let unseededTeam = self.extractOneTeam(&opponents)
                    
                    unseededTeams.removeAll { team in
                        team == unseededTeam
                    }
                    
                    // in each draw, we are absolutely sure that there cannot be 2 pairings of the same teams
                    // because as soon as a team or its opponent is picked, we discard them from the arrays
                    // so: we can just add the current pairing to our local tuples without checking if it exists first
                    //                                loopPairings.append((seededTeam: seededTeam, unseededTeam: unseededTeam))
                    
                }
            //
            //                // if the draw has been completed (thus is valid) we increase the count for all the matching pairings
            //                // we look for an existing pairing matching the current iteration
            //                // if there is one, we increase the count, otherwise we create the pairing
            //                for loopPairing in loopPairings {
            //
            //
            ////                    _pairings = FetchRequest<Pairing>(sortDescriptors: [], predicate: NSPredicate(format: "seededTeamId = %@ AND unseededTeamId = %@", [loopPairing.seededTeam.id, loopPairing.unseededTeam.id]))
            //
            //
            //
            ////                    if let pairingIndex =
            ////                        taskPairings.firstIndex(
            ////                            where: { p in
            ////                                p.seededTeam == loopPairing.seededTeam
            ////                                && p.unseededTeam == loopPairing.unseededTeam
            ////                            }
            ////                        )
            ////                    {
            ////                        taskPairings[pairingIndex].count += 1
            ////                    } else {
            ////                        taskPairings.append(Pairing(seededTeam: loopPairing.seededTeam, unseededTeam: loopPairing.unseededTeam, count: 1))
            ////                    }
            //                }
            //            }
            //
            }
            
            await MainActor.run {
                isRunning = false
            }
        }
    }
    
    // no need to batch delete here because there will be a fairly small amount of data every time, probably around 64
    private func deleteDraws(for season: Season) {
        
        CoreDataController.shared.performInBackgroundContextAndWait(commit: false) { moc in
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
    
    private func getTeams(for season: Season, seeded: Bool) -> [DrawTeam] {
        var result = [DrawTeam]()

        CoreDataController.shared.performInBackgroundContextAndWait(commit: false) { moc in
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
