//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI
import CoreData

struct TeamDetailView: View {
    
    @EnvironmentObject private var draws: Draws
    @EnvironmentObject private var userSettings: UserSettings
    
    let seasonTeam: SeasonTeam
    let team: Team
    
    private var opponentsSeasonTeams: [SeasonTeam] {
        seasonTeam.season!.seasonTeamsArray.filter {
            $0.seeded != seasonTeam.seeded
            && $0.poolName != seasonTeam.poolName
            && $0.team!.country != team.country
        }
    }
    
    init(seasonTeam: SeasonTeam) {
        self.seasonTeam = seasonTeam
        self.team = seasonTeam.team!
    }
    
    var body: some View {
        
        List {
            // first section is the current team card
            TeamIdentityCardView(seasonTeam: seasonTeam)
            
            // second section is the list of opponents
            Section {
                ForEach(opponentsSeasonTeams) { opponentSeasonTeam in
                    OpponentView(seasonTeam: seasonTeam, opponent: opponentSeasonTeam)
                }
                .listRowSeparatorTint(.blueTheme)
            } header: {
                Text("Draw chances")
                    .sectionTitle()
            }
        }
        .navigationTitle(team.name)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                if draws.isRunning {
                    HStack {
                        ProgressView(value: draws.progress, total: Double(userSettings.drawAccuracyCount))
                            .tint(Color.blueTheme)
                        
                        Button {
                            if draws.task != nil {
                                draws.cancelDraw()
                            }
                        } label: {
                            Label("Cancel draw", systemImage: "xmark")
                                .font(.title2)
                                .foregroundColor(.red)
                                .labelStyle(.iconOnly)
                        }
                        .accessibilityHint("Will cancel the running draw.")
                    }
                } else {
                    Button {
                        draws.draw(for: seasonTeam.season!.winYear, times: userSettings.drawAccuracyCount)
                    } label: {
                        Label("Run draw", systemImage: "play")
                            .navigationStackActionButtonLabel()
                    }
                    .accessibilityHint("Will start a draw for the whole season.")
                }
            }
        }
    }
}


struct TeamDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let seasonTeam = PreviewDataFetcher.fetchData(
            for: SeasonTeam.self,
            withPredicate: NSPredicate(format: "team.shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )
        
        return TabView {
            
            NavigationStack {
                TeamDetailView(seasonTeam: seasonTeam)
                    .environment(\.managedObjectContext, CoreDataController.preview.mainContext)
                    .environmentObject(UserSettings())
                    .environmentObject(Draws(coreDataController: CoreDataController.preview))
            }
            .tabItem {
                Text("dummy preview tab view")
            }
        }
        
    }
}
