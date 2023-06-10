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
    
    let teamPool: TeamPool
    let team: Team
    
    @FetchRequest private var seasonPools: FetchedResults<TeamPool>
    
    var opponents: [Team] {
        return seasonPools
            .filter {
                $0.seeded != teamPool.seeded &&
                $0.team!.country != team.country &&
                $0.name != teamPool.name
            }
            .map {
                $0.team!
            }
    }

    private var logoSize: CGFloat { geoSizeTracker.getSize().width * (dynamicTypeSize >= .accessibility2 ? 0.75 : 0.45) }

    init(teamPool: TeamPool) {
        self.teamPool = teamPool
        self.team = teamPool.team!
        
        _seasonPools = FetchRequest(
            sortDescriptors: [],
            predicate: NSPredicate(format: "season == %@", teamPool.season!)
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
            //            Text("Team Detail View")
            
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
                                PoolLabelView(teamPool: teamPool)
                                
                                DividerView()
                                
                                FlagLabelView(team: team)
                                
                                DividerView()
                                
                                Text(teamPool.seededString)
                            }
                        }
                        .font(.title2.bold())
                    }
                    
                    CardView(hasHeaderDivier: true) {
                        VStack(spacing: 0) {
                            ForEach(opponents, id: \.self) { opponent in
                                HStack {
                                    TeamLabelView(team: opponent, logoWidthPercentage: 12)
                                        .padding(.trailing, 10)
                                    
                                    HStack {
//                                        if draws.isRunning {
//                                            ProgressView(value: draws.progress, total: Double(Draws.numberOfDraws))
//                                                .progressViewStyle(RandomNumberProgressStyle())
//                                        } else {
//                                            Text(getOpponentPercentageString(for: opponent))
//                                        }
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
//                    } footer: {
//                        if draws.isRunning {
//                            ProgressView(value: draws.progress, total: Double(Draws.numberOfDraws))
//                                .progressViewStyle(ButtonProgressStyle())
//                                .onTapGesture {
//                                    if draws.task != nil {
//                                        draws.cancelDraw()
//                                    }
//                                }
//                        } else {
//                            List(pairings) { pairing in
//                                Text("count: \(pairing.count)")
//                            }
//
//                            Button {
//                                draws.draw()
//                            } label: {
//                                Text("Draw")
//                                    .frame(maxWidth: .infinity)
//                            }
//                            .disabled(draws.isRunning)
//                            .padding(10)
//                            .background(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(draws.isRunning ? .gray : Color.pitchGreen)
//                            )
//                            .font(.title2.bold())
//                        }
                    }
                }
                .padding(.horizontal, 15)
            }
        }
        .navigationTitle(team.name)
    }
}

//struct TeamDetailView_Previews: PreviewProvider {
//    static let geo = GeoSizeTracker()
//    static let draws = Draws()
////    static let teams = Teams.data
//
//    static var previews: some View {
//        NavigationStack {
//            TeamDetailView(team: teams.first!)
//                .environmentObject(geo)
//                .environmentObject(draws)
//        }
//    }
//}
