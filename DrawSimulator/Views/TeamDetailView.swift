//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.managedObjectContext) private var moc
    
    @EnvironmentObject private var draws: Draws
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    let seasonTeam: SeasonTeam
    let team: Team
    
    @FetchRequest private var opponentSeasonTeams: FetchedResults<SeasonTeam>
    @FetchRequest private var drawPairings: FetchedResults<DrawPairing>
    
    private struct Opponent: Hashable {
        let team: Team
        let pairingCount: Int
    }
    
    private var opponents: [Opponent] {
        var result = [Opponent]()
        
        for seasonTeam in opponentSeasonTeams {
            
            let opponentTeam = seasonTeam.team!
            
            let pairing = drawPairings.first {
                self.seasonTeam.seeded
                ? $0.unseededTeam == opponentTeam
                : $0.seededTeam == opponentTeam
            }
            
            if let pairing {
                result.append(
                    Opponent(
                        team: opponentTeam,
                        pairingCount: Int(pairing.count)
                    )
                )
            } else {
                print("Could not find a drawPairing (team: \(self.team.name), opponent: \(opponentTeam.name)")
            }
        }
        
        return result
    }
    
    private var logoSize: CGFloat {
        geoSizeTracker.getSize().width * (dynamicTypeSize >= .accessibility2 ? 0.75 : 0.45)
    }
    
    init(seasonTeam: SeasonTeam) {
        self.seasonTeam = seasonTeam
        self.team = seasonTeam.team!
        
        _opponentSeasonTeams = FetchRequest(
            sortDescriptors: [],
            predicate: NSPredicate( // no problem for the team.country condition, because the database is initialized with safeguards
                format: "season == %@ AND seeded != %@ AND poolName != %@ AND team.country != %@",
                seasonTeam.season!,
                seasonTeam.seeded as NSNumber,
                seasonTeam.poolName,
                team.country!
            )
        )
        
        let teamColumn =  seasonTeam.seeded ? "seededTeam" : "unseededTeam"
        
        _drawPairings = FetchRequest(
            sortDescriptors: [],
            predicate: NSPredicate(
                format: "season == %@ AND \(teamColumn) == %@",
                seasonTeam.season!,
                team
            )
        )
    }
    
    
    //    private var drawsCount: Int {
    //        pairingCounts.values.reduce(0) { acc, count in
    //            acc + count
    //        }
    //    }
    //
    //    private func getOpponentPercentageString(for opponent: Team) -> String {
    //
    //        if let count = pairingCounts[opponent] {
    //            return "\((Float(count) / Float(drawsCount) * 100).rounded().formatted())"
    //        }
    //
    //        return "?"
    //    }
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    CardView {
                        DynamicTypeStack(.accessibility2) {
                            
                            Image(team.shortName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: logoSize, height: logoSize)
                            
                            VStack {
                                PoolLabelView(seasonTeam: seasonTeam)
                                
                                DividerView()
                                
                                FlagLabelView(team: team)
                                
                                DividerView()
                                
                                Text(seasonTeam.seededString)
                            }
                        }
                        .font(.title2.bold())
                    }
                    
                    CardView(hasHeaderDivier: true) {
                        VStack(spacing: 0) {
                            ForEach(opponents, id: \.self) { opponent in
                                HStack {
                                    TeamLabelView(team: opponent.team, logoWidthPercentage: 12)
                                        .padding(.trailing, 10)
                                    
                                    HStack {
                                        if draws.isRunning {
                                            ProgressView(value: draws.progress, total: Double(Draws.numberOfDraws))
                                                .progressViewStyle(RandomNumberProgressStyle())
                                        } else {
                                            Text(String(opponent.pairingCount))
//                                            Text(getOpponentPercentageString(for: opponent))
                                        }
                                        Text("%")
                                    }
                                    .font(.custom(Fonts.Overpass.bold.rawValue, size: 20, relativeTo: .largeTitle))
                                }
                                .padding(.vertical, 4)
                                
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
                                .onTapGesture {
                                    if draws.task != nil {
                                        draws.cancelDraw()
                                    }
                                }
                        } else {
                            Button {
                                draws.draw(for: seasonTeam.season!.winYear)
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
