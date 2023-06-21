//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI
import CoreData

struct TeamDetailView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @EnvironmentObject private var draws: Draws
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    let seasonTeam: SeasonTeam
    let team: Team
    
    private var logoSize: CGFloat {
        geoSizeTracker.getSize().width * (dynamicTypeSize >= .accessibility2 ? 0.75 : 0.45)
    }
    
    private var opponentsSeasonTeams: [SeasonTeam] {
        seasonTeam.season!.seasonTeamsArray.filter {
            $0.seeded != seasonTeam.seeded
            && $0.poolName != seasonTeam.poolName
            && $0.team!.country != team.country
        }
    }
    
    private var drawPairings: [DrawPairing] {
        seasonTeam.season!.drawPairingsArray.filter {
            if seasonTeam.seeded {
                return $0.seededTeam == team
            } else {
                return $0.unseededTeam == team
            }
        }
    }
    
    private var totalPairingCount: Float {
        Float(
            drawPairings.reduce(0) { acc, drawPairing in
                acc + drawPairing.count
            }
        )
    }
    
    private func getOpponentPercentageString(for opponent: Team) -> String {
        
        let pairing = drawPairings.first(where: {
            if seasonTeam.seeded {
                return $0.unseededTeam == opponent
            } else {
                return $0.seededTeam == opponent
            }
        })
        
        guard let pairing else { return "n/a" }
        
        return "\((Float(pairing.count) / totalPairingCount * 100).rounded().formatted()) %"
    }
    
    init(seasonTeam: SeasonTeam) {
        self.seasonTeam = seasonTeam
        self.team = seasonTeam.team!
    }
    
    var body: some View {
        
        List {
            Section {
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
            .listSectionSeparator(.hidden)
            
            Section {
                ForEach(opponentsSeasonTeams) { opponentSeasonTeam in
                    HStack {
                        TeamLabelView(team: opponentSeasonTeam.team!, textStyle: .title2)
                            .padding(.trailing, 10)
                        
                        Spacer()
                        
                        HStack {
                            if draws.isRunning {
                                ProgressView(value: draws.progress, total: Double(Draws.numberOfDraws))
                                    .progressViewStyle(RandomNumberProgressStyle())
                                Text("%")
                            } else {
                                Text(getOpponentPercentageString(for: opponentSeasonTeam.team!))
                            }
                        }
                        .font(.custom(Fonts.Overpass.bold.rawValue, size: 20, relativeTo: .largeTitle))
                    }
                }
                .listRowSeparatorTint(.pitchGreen)
            } header: {
                Text("Draw chances")
                    .font(.title2.bold())
                    .foregroundColor(.pitchGreen)
            }
            
            
        }
        .navigationTitle(team.name)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                if draws.isRunning {
                    ProgressView(value: draws.progress, total: Double(Draws.numberOfDraws))
                        .tint(Color.pitchGreen)
                } else {
                    Button {
                        draws.draw(for: seasonTeam.season!.winYear)
                    } label: {
                        Text("Draw")
                            .font(.title2)
                    }
                    .disabled(draws.isRunning)
                    .padding(10)
                    .foregroundColor(Color.pitchGreen)
                }
            }
        }
    }
}


struct TeamDetailView_Previews: PreviewProvider {
    
    static var geoSizeTracker = GeoSizeTracker()
    
    static var previews: some View {
        
        let seasonTeam = PreviewDataFetcher.fetchData(
            for: SeasonTeam.self,
            withPredicate: NSPredicate(format: "team.shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )
        
        return ZStack {
            GeometryReader { geoWrapper in
                Spacer()
                    .onAppear {
                        geoSizeTracker.setSize(geoWrapper.size)
                    }
            }
            
            NavigationStack {
                TeamDetailView(seasonTeam: seasonTeam)
                    .environment(\.managedObjectContext, CoreDataController.preview.mainContext)
                    .environmentObject(geoSizeTracker)
                    .environmentObject(Draws(coreDataController: CoreDataController.preview))
            }
        }
    }
}
