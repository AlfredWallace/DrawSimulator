//
//  Draws.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 17/04/2023.
//

import Foundation
import SwiftUI

@MainActor class Draws: ObservableObject {
    
    @Environment(\.managedObjectContext) private var moc
//    @FetchRequest(sortDescriptors: []) private var pairings: FetchedResults<Pairing>
    
    private static let savePath = FileManager.documentsDirectory.appendingPathComponent("draws.json")
    static let numberOfDraws = 100
    
//    @Published private(set) var pairings = [Pairing]()
    @Published private(set) var isRunning = false
    @Published private(set) var progress = 0.0
    
    private(set) var task: Task<Void, Never>? = nil
//    private var pairingsBackup = [Pairing]()
    
    private func extractOneTeam(_ teams: inout [Team]) -> Team {
        let length = teams.count
        return teams.remove(at: Int.random(in: 0..<length))
    }
    
    func cancelDraw() {
        isRunning = false
    }
    
    func draw(_ times: Int = numberOfDraws) {
        isRunning = true
        progress = 0.0
        
//        task = Task {
////            pairingsBackup = pairings
//
////            var taskPairings = [Pairing]()
//
//            outerLoop: for _ in 0..<times {
//
////                if isRunning == false {
////                    if let task {
////                        task.cancel()
////                        pairings = pairingsBackup
////                    }
////                }
//
//                // we will always pick a seeded team then pair it with an unseeded team (UEFA rule): this eliminates some complexity of the algorithm
//                var seededTeams = Teams.data.filter({ $0.seeded })
//                var unseededTeams = Teams.data.filter({ !$0.seeded })
//                var loopPairings = [(seededTeam: Team, unseededTeam: Team)]()
//
//                await MainActor.run {
//                    self.progress += 1.0
//                }
//
//                while seededTeams.isEmpty == false {
//
//                    let seededTeam = self.extractOneTeam(&seededTeams)
//
//                    //UEFA rules
//                    var opponents = unseededTeams.filter { opponent in
//                        opponent.countryId != seededTeam.countryId
//                        && opponent.pool != seededTeam.pool
//                    }
//
//                    // invalid draw, we discard it completely (when at some point in the draw, the remaining teams are not compatible with the rules)
//                    // so: we won't add any of the tuples (localPairings) to our Pairing array (pairings)
//                    if opponents.isEmpty {
//                        continue outerLoop
//                    }
//
//                    let unseededTeam = self.extractOneTeam(&opponents)
//
//                    unseededTeams.removeAll { team in
//                        team == unseededTeam
//                    }
//
//                    // in each draw, we are absolutely sure that there cannot be 2 pairings of the same teams
//                    // because as soon as a team or its opponent is picked, we discard them from the arrays
//                    // so: we can just add the current pairing to our local tuples without checking if it exists first
//                    loopPairings.append((seededTeam: seededTeam, unseededTeam: unseededTeam))
//                }
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
////            await MainActor.run { [taskPairings] in
////                self.isRunning = false
////                self.pairings = taskPairings
////                self.save()
////            }
//        }
    }
    
    private func save() {
    }
}
