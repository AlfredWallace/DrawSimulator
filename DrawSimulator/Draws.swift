//
//  Draws.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 17/04/2023.
//

import Foundation

@MainActor class Draws: ObservableObject {
    
    struct Pairing: Hashable {
        let seededTeam: Team
        let unseededTeam: Team
        var count: Int
    }
    
    @Published private(set) var pairings = [Pairing]()
    @Published private(set) var isRunning = false
    @Published var progress = 0.0
    static let numberOfDraws = 10_000
    
    private func extractOneTeam(_ teams: inout [Team]) -> Team {
        let length = teams.count
        return teams.remove(at: Int.random(in: 0..<length))
    }
    
    func draw(_ times: Int = numberOfDraws) {
        isRunning = true
        progress = 0.0
        
        Task.detached {
            
            var pairings = [Pairing]()
            
            outerLoop: for _ in 0..<times {
                
                // we will always pick a seeded team then pair it with an unseeded team (UEFA rule): this eliminates some complexity of the algorithm
                var seededTeams = Teams.data.filter({ $0.seeded })
                var unseededTeams = Teams.data.filter({ !$0.seeded })
                var localPairings = [(seededTeam: Team, unseededTeam: Team)]()
                
                await MainActor.run {
                    self.progress += 1.0
                }
                
                while seededTeams.isEmpty == false {
                    
                    let seededTeam = await self.extractOneTeam(&seededTeams)
                    
                    //UEFA rules
                    var opponents = unseededTeams.filter { opponent in
                        opponent.countryId != seededTeam.countryId
                        && opponent.pool != seededTeam.pool
                    }
                    
                    // invalid draw, we discard it completely (when at some point in the draw, the remaining teams are not compatible with the rules)
                    // so: we won't add any of the tuples (localPairings) to our Pairing array (pairings)
                    if opponents.isEmpty {
                        continue outerLoop
                    }
                    
                    let unseededTeam = await self.extractOneTeam(&opponents)
                    
                    unseededTeams.removeAll { team in
                        team == unseededTeam
                    }
                    
                    // in each draw, we are absolutely sure that there cannot be 2 pairings of the same teams
                    // because as soon as a team or its is picked, we discard them from the arrays
                    // so: we can just add the current pairing to our local tuples
                    localPairings.append((seededTeam: seededTeam, unseededTeam: unseededTeam))
                }
                
                // if the draw has been completed (thus is valid) we increase the count for all the matching pairings
                // we look for an existing pairing matching the current iteration
                // if there is one, we increase the count, otherwise we create the pairing
                for localPairing in localPairings {
                    if let pairingIndex = pairings.firstIndex(where: {
                        p in p.seededTeam == localPairing.seededTeam && p.unseededTeam == localPairing.unseededTeam
                    }) {
                        pairings[pairingIndex].count += 1
                    } else {
                        pairings.append(Pairing(seededTeam: localPairing.seededTeam, unseededTeam: localPairing.unseededTeam, count: 1))
                    }
                }
            }
            
            await MainActor.run { [pairings] in
                self.isRunning = false
                self.pairings = pairings
            }
        }
    }
}
