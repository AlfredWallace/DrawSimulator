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
                        Text("Draw chances")
                            .font(.title2.bold())
                        
                        DividerView()
                        
                        ForEach(opponents, id: \.self) { opponent in
                            HStack {
                                TeamLogoView(team: opponent, widthPercentage: 8)
                                
                                Text(opponent.name.uppercased())
                                    .font(.custom(SharedConstants.Chillax.bold.rawValue, size: 16, relativeTo: .largeTitle))
                                
                                Spacer()
                                
                                if draws.isRunning {
                                    ProgressView()
                                } else {
                                    
                                    
                                    if let count = pairingCounts[opponent] {
                                        Text("\((Float(count) / Float(drawsCount) * 100).rounded().formatted()) %")
                                    } else {
                                        Text("no data")
                                    }
                                }
                            }
                        }
                        
                        Button {
                            Task {
                                await draws.draw(1_000)
                            }
                        } label: {
                            Spacer()
                            if draws.isRunning {
                                ProgressView()
                            } else {
                                Text("Draw")
                            }
                            Spacer()
                        }
                        .disabled(draws.isRunning)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(draws.isRunning ? .gray : Color.pitchGreen)
                        )
                        .foregroundColor(Color.defaultText)
                        .font(.title2.bold())
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

struct TeamDetailView_Previews: PreviewProvider {
    static let geo = GeoSizeTracker()
    static let draws = Draws()
    static let teams = SharedConstants.teams
    
    static var previews: some View {
        NavigationStack {
            TeamDetailView(team: teams.first!)
                .environmentObject(geo)
                .environmentObject(draws)
        }
    }
}
