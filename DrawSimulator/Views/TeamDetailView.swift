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
        Teams.data.filter { opponent in
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
    
    private func getOpponentPercentageString(for opponent: Team) -> String {
        let suffix = "%"
        
        if let count = pairingCounts[opponent] {
            return "\((Float(count) / Float(drawsCount) * 100).rounded().formatted()) \(suffix)"
        }
        
        return "? \(suffix)"
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    CardView {
                        DynamicTypeStack(.accessibility2) {
                            TeamLogoView(team: team, widthPercentage: dynamicTypeSize >= .accessibility2 ? 75 : 45)
                            
                            VStack {
                                PoolLabelView(team: team)
                                
                                DividerView()
                                
                                FlagLabelView(team: team)
                                
                                DividerView()
                                
                                Text(team.seeded ? "Seeded" : "Unseeded")
                            }
                        }
                        .font(.title2.bold())
                    }
                    
                    CardView(hasHeaderDivier: true) {
                        VStack(spacing: 8) {
                            ForEach(opponents, id: \.self) { opponent in
                                HStack {
                                    ScrollView(.horizontal) {
                                        HStack {
                                            TeamLogoView(team: opponent, widthPercentage: 10)
                                            
                                            Text(opponent.name.uppercased())
                                                .font(.custom(Fonts.Chillax.bold.rawValue, size: 22, relativeTo: .largeTitle))
                                        }
                                    }
                                    .scrollIndicators(.hidden)
                                    .padding(.trailing, 10)
                                    
                                    if draws.isRunning {
                                        ProgressView()
                                    } else {
                                        Text(getOpponentPercentageString(for: opponent))
                                            .font(.custom(Fonts.SourceCodePro.romanBold.rawValue, size: 22, relativeTo: .largeTitle))
                                    }
                                }
                                
                                Divider()
                            }
                        }
                    } header: {
                        Text("Draw chances")
                            .font(.title2.bold())
                    } footer: {
                        if draws.isRunning {
                            ProgressView(value: draws.progress, total: Double(Draws.numberOfDraws))
                                .progressViewStyle(ButtonProgressStyle())
                        } else {
                            Button {
                                draws.draw()
                            } label: {
                                Text("Draw")
                                    .frame(maxWidth: .infinity)
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
                    }
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
    static let teams = Teams.data
    
    static var previews: some View {
        NavigationStack {
            TeamDetailView(team: teams.first!)
                .environmentObject(geo)
                .environmentObject(draws)
        }
    }
}
