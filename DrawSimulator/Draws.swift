//
//  Draws.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 17/04/2023.
//

import Foundation

class Draws: ObservableObject {
    
    struct Pairing: Hashable {
        let seededTeam: Team
        let unseededTeam: Team
        var count: Int
    }
    
    private(set) var pairings = [Pairing]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    private(set) var isRunning = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    private func extractOneTeam(_ teams: inout [Team]) -> Team {
        let length = teams.count
        return teams.remove(at: Int.random(in: 0..<length))
    }
    
    private func drawOnce() {
        
        // we will always pick a seeded team then pair it with an unseeded team (UEFA rule): this eliminates some complexity of the algorithm
        var seededTeams = Teams.data.filter({ $0.seeded })
        var unseededTeams = Teams.data.filter({ !$0.seeded })
        
        while seededTeams.isEmpty == false {
            let seededTeam = extractOneTeam(&seededTeams)
            
            //UEFA rules
            var opponents = unseededTeams.filter { opponent in
                opponent.countryId != seededTeam.countryId
                && opponent.pool != seededTeam.pool
            }
            
            // invalid draw, we discard it completely (typically when the remaining teams are not compatible with the rules)
            if opponents.isEmpty {
                continue
            }
            
            let unseededTeam = extractOneTeam(&opponents)
            
            unseededTeams.removeAll { team in
                team == unseededTeam
            }
            
            // we look for an existing pairing matching the current iteration, if there is one, we increase the count, otherwise we create the pairing
            if let pairingIndex = pairings.firstIndex(where: {
                p in p.seededTeam == seededTeam && p.unseededTeam == unseededTeam
            }) {
                pairings[pairingIndex].count += 1
            } else {
                pairings.append(Pairing(seededTeam: seededTeam, unseededTeam: unseededTeam, count: 1))
            }
        }
    }
    
    func draw(_ times: Int = 1) async {
        isRunning = true
        for _ in 0..<times {
            drawOnce()
        }
        isRunning = false
    }
}
