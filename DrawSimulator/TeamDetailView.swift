//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @EnvironmentObject private var draws: Draws
    
    let team: Team
    
    private var opponents: [Team] {
        SharedConstants.teams.filter { opponent in
            opponent.seeded != team.seeded
            && opponent.countryId != team.countryId
            && opponent.pool != team.pool
        }
    }
    
    private var pairingCounts: [Team: Int] {
        
        guard draws.pairings.isEmpty == false else { return [:] }
        
        var result = [Team: Int]()
        
        for opponent in opponents {
            if let pairing = draws.pairings.first(where: { p in
                if team.seeded {
                    return p.seededTeam == team && p.unseededTeam == opponent
                }
                
                return p.unseededTeam == team && p.seededTeam == opponent
            }) {
                result[opponent] = pairing.count
            }
        }
        
        if result.isEmpty { return [:] }
        
        return result
    }
    
    private var drawsCount: Int {
        pairingCounts.values.reduce(0) { acc, count in
            acc + count
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    ViewThatFits {
                        HStack {
                            TeamLogoView(team: team, widthPercentage: 45)
                            
                            VStack {
                                PoolLabelView(team: team)
                                
                                DividerView()
                                
                                FlagLabelView(team: team)
                                
                                DividerView()
                                
                                Text(team.seeded ? "Seeded" : "Unseeded")
                            }
                        }
                        
                        VStack {
                            TeamLogoView(team: team, widthPercentage: 75)
                            
                            PoolLabelView(team: team)
                            
                            DividerView()
                            
                            FlagLabelView(team: team)
                            
                            DividerView()
                            
                            Text(team.seeded ? "Seeded" : "Unseeded")
                            
                        }
                        
                    }
                    .font(.title3.bold())
                    .padding(10)
                    .carded()
                    
                    VStack {
                        ForEach(opponents, id: \.self) { opponent in
                            HStack {
                                Text(opponent.name)
                                
                                Spacer()
                                
                                if let count = pairingCounts[opponent] {
                                    Text("\((Float(count) / Float(drawsCount) * 100).rounded().formatted()) %")
                                } else {
                                    Text("no data")
                                }
                            }
                        }
                    }
                    .padding(15)
                    .carded()
                    
                    Button("draw") {
                        draws.draw(100)
                    }
                    .padding(15)
                    .carded()
                }
                .padding(.horizontal, 15)
            }
        }
        .navigationTitle(team.name)
    }
}

