//
//  SeasonDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 07/04/2023.
//

import SwiftUI
import CoreData

struct SeasonDetailView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    
    let season: Season
    
    @State private var showingGroupingDialog = false
    @State private var showingList = true
    
    @SectionedFetchRequest private var teamPoolsByPool: SectionedFetchResults<String, TeamPool>
    @SectionedFetchRequest private var teamPoolsBySeeding: SectionedFetchResults<String, TeamPool>
    @SectionedFetchRequest private var teamPoolsByCountry: SectionedFetchResults<String, TeamPool>
    @SectionedFetchRequest private var teamPoolsUngrouped: SectionedFetchResults<String, TeamPool>
    
    init(season: Season) {
        self.season = season
        
        // force unwrap is possible because the data is fully checked before being inserted into DB (see DatabaseInitializer)
        
        _teamPoolsByPool = SectionedFetchRequest(
            sectionIdentifier: \.name,
            sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.seeded, order: .reverse)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _teamPoolsBySeeding = SectionedFetchRequest(
            sectionIdentifier: \.seededString,
            sortDescriptors: [SortDescriptor(\.seeded, order: .reverse), SortDescriptor(\.team!.sortingName)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _teamPoolsByCountry = SectionedFetchRequest(
            sectionIdentifier: \.team!.country!.name,
            sortDescriptors: [SortDescriptor(\.team!.country!.name), SortDescriptor(\.team!.sortingName)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _teamPoolsUngrouped = SectionedFetchRequest(
            sectionIdentifier: \.season!.winYearString,
            sortDescriptors: [SortDescriptor(\.team!.sortingName)],
            predicate: NSPredicate(format: "season == %@", season)
        )
    }
    
    
    private var teamPools: SectionedFetchResults<String, TeamPool> {
        switch userSettings.data.grouping {
            case .country:
                return teamPoolsByCountry
            case .none:
                return teamPoolsUngrouped
            case .seeding:
                return teamPoolsBySeeding
            default:
                return teamPoolsByPool
        }
    }
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            VStack {
                if showingList {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(teamPools) { section in
                                
                                CardView(hasHeaderDivier: true) {
                                    VStack(spacing: 10) {
                                        ForEach(section) { teamPool in
                                            let team = teamPool.team!
                                            NavigationLink(value: team) {
                                                HStack {
                                                    TeamLabelView(team: team)
                                                    Image(systemName: "chevron.forward")
                                                }
                                            }
                                        }
                                    }
                                    .padding(.vertical, 5)
                                } header: {
                                    Text(section.id)
                                        .font(.title2.bold())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.hidden)
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .navigationDestination(for: Team.self) { team in
            TeamDetailView(team: team)
        }
        .navigationTitle("Teams")
        .toolbar {
            //            ToolbarItem {
            //                Menu {
            //                    DisplayModeMenuButtonView(displayMode: .light)
            //                    DisplayModeMenuButtonView(displayMode: .dark)
            //                    DisplayModeMenuButtonView(displayMode: .system)
            //                } label: {
            //                    Label("Display mode", systemImage: userSettings.getDisplayModeIconName())
            //                }
            //            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                GroupingDialogButtonView(showingDialg: $showingGroupingDialog)
            }
        }
        .confirmationDialog("Change team grouping", isPresented: $showingGroupingDialog) {
            GroupingDialogChoiceView(grouping: .pool, showingList: $showingList)
            GroupingDialogChoiceView(grouping: .country, showingList: $showingList)
            GroupingDialogChoiceView(grouping: .seeding, showingList: $showingList)
            GroupingDialogChoiceView(grouping: .none, showingList: $showingList)
        }
    }
}

