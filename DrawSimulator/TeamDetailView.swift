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
    
    var pairings: [Draws.Pairing] {
        draws.pairings.filter { pairing in
            if team.seeded {
                return pairing.seededTeam == team
            } else {
                return pairing.unseededTeam == team
            }
        }
    }
    
    var drawsCount: Int {
        pairings.reduce(0) { acc, pairing in
            acc + pairing.count
        }
    }
    
    private func pairingPercentage(_ pairing: Draws.Pairing) -> Float {
        Float(pairing.count) / Float(drawsCount) * 100
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
                    
                    if pairings.isEmpty == false {
                        VStack {
                            Text("\(drawsCount)")
                            ForEach(pairings, id: \.self) { pairing in
                                HStack {
                                    Text("\(team.seeded ? pairing.unseededTeam.name : pairing.seededTeam.name)")
                                    Spacer()
                                    Text("\(pairingPercentage(pairing).rounded().formatted()) % (\(pairing.count))")
                                }
                            }
                        }
                        .padding(15)
                        .carded()
                    }
                    
                    
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

