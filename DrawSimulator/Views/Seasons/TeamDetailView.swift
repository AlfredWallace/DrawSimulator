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
    @EnvironmentObject private var userSettings: UserSettings
    
    let seasonTeam: SeasonTeam
    let team: Team
    
    private var logoSize: CGFloat {
        var factor = 1.0
        
        switch dynamicTypeSize {
            case .xSmall:
                factor = 0.36
            case .small:
                factor = 0.38
            case .medium:
                factor = 0.40
            case .large:
                factor = 0.42
            case .xLarge:
                factor = 0.44
            case .xxLarge:
                factor = 0.46
            default:
                factor = 0.75
        }
        
        return geoSizeTracker.getSize().width * factor
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
    
    private func getOpponentPercentage(for opponent: Team) -> Float {
        
        let pairing = drawPairings.first(where: {
            if seasonTeam.seeded {
                return $0.unseededTeam == opponent
            } else {
                return $0.seededTeam == opponent
            }
        })
        
        guard let pairing else { return 0.0 }
        
        return Float(pairing.count) / totalPairingCount * 100
    }
    
    init(seasonTeam: SeasonTeam) {
        self.seasonTeam = seasonTeam
        self.team = seasonTeam.team!
    }
    
    var body: some View {
        
        List {
            Section {
                StackThatFits() {
                    
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
                            Spacer()
                            
                            if draws.isRunning {
                                ProgressView(value: draws.progress, total: Double(userSettings.data.numberOfDraws))
                                    .progressViewStyle(RandomNumberProgressStyle())
                            } else {
                                Text("\(getOpponentPercentage(for: opponentSeasonTeam.team!).rounded().formatted())")
                            }
                            Text("%")
                        }
                        .frame(width: geoSizeTracker.getSize().width * 0.23)
                        .font(.title3.bold().monospaced())
                    }
                }
                .listRowSeparatorTint(.pitchGreen)
            } header: {
                SectionTitleStyleView("Draw chances")
            }
            
            
        }
        .navigationTitle(team.name)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                if draws.isRunning {
                    HStack {
                        ProgressView(value: draws.progress, total: Double(userSettings.data.numberOfDraws))
                            .tint(Color.pitchGreen)
                        
                        Button {
                            if draws.task != nil {
                                draws.cancelDraw()
                            }
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                                .font(.title2)
                                .foregroundColor(.red)
                                .labelStyle(.iconOnly)
                        }
                    }
                } else {
                    Button {
                        draws.draw(for: seasonTeam.season!.winYear, times: userSettings.data.numberOfDraws)
                    } label: {
                        Label("Run draw", systemImage: "play")
                            .navigationStackActionButtonLabel()
                    }
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
            
            TabView {
                
                NavigationStack {
                    TeamDetailView(seasonTeam: seasonTeam)
                        .environment(\.managedObjectContext, CoreDataController.preview.mainContext)
                        .environmentObject(geoSizeTracker)
                        .environmentObject(Draws(coreDataController: CoreDataController.preview))
                }
                .tabItem {
                    Text("dummy preview tab view")
                }
            }
        }
    }
}
