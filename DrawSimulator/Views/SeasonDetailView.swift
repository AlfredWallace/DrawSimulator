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
    
    @SectionedFetchRequest(
        sectionIdentifier: \.name,
        sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.seeded, order: .reverse)]
    ) private var teamPools: SectionedFetchResults<String, TeamPool>
    
    
    //    private struct PoolGrouping {
    //        let poolName: String
    //        let seededTeam: Team
    //        let unseededTeam: Team
    //    }
    //
    //    private var poolGrouping: [PoolGrouping] {
    //        var result = [PoolGrouping]()
    //
    //        for teamPool in teamPools {
    //
    //        }
    //
    //        return result
    //    }
    //
    //    private var teamsGroupedByCountry: [[Team]] {
    //
    //        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
    //        let teamsByName = Teams.data.sorted {
    //            $0.name < $1.name
    //        }
    //
    //        // then we group teams by contry, and sort the groups by number of teams then country name
    //        return Array(Dictionary(grouping: teamsByName, by: { $0.countryId }).values).sorted { lhs, rhs in
    //            if lhs.count == rhs.count {
    //                return Countries.data[lhs[0].countryId]!.name < Countries.data[rhs[0].countryId]!.name
    //            }
    //
    //            return lhs.count > rhs.count
    //
    //        }
    //    }
    //
    //    private var teamsGroupedBySeeding: [[Team]] {
    //
    //        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
    //        let teamsByName = Teams.data.sorted {
    //            $0.name < $1.name
    //        }
    //
    //        // then we group teams by seeding, and sort the groups by putting the seeding teams first
    //        return Array(Dictionary(grouping: teamsByName, by: { $0.seeded }).values).sorted { lhs, _ in lhs.first!.seeded }
    //    }
    //
    //    private var teamsUngrouped: [[Team]] {
    //        var result = [[Team]]()
    //
    //        result.append(Teams.data.sorted {
    //            $0.name < $1.name
    //        })
    //
    //        return result
    //    }
    //
    //    private var groupedTeams: [[Team]] {
    //        switch userSettings.data.grouping {
    //            case .country:
    //                return teamsGroupedByCountry
    //            case .pool:
    //                return teamsGroupedByPool
    //            case .seeding:
    //                return teamsGroupedBySeeding
    //            default:
    //                return teamsUngrouped
    //        }
    //    }
    
    var body: some View {
        VStack {
            if showingList {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(teamPools) { section in
                            
                            CardView(hasHeaderDivier: true) {
                                VStack(spacing: 10) {
                                    ForEach(section) { teamPool in
                                        NavigationLink(value: teamPool) {
                                            HStack {
                                                //TeamLabelView(team: team)
                                                Text("\(teamPool.team?.name ?? "no team") (\(teamPool.name))")
                                                Image(systemName: "chevron.forward")
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, 5)
                            } header: {
                                Text(section.id)
                                //TeamGroupTitleView(team: teamGroup.first!)
                                //  .font(.title2.bold())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
                .transition(.move(edge: .bottom))
            }
        }
        .background {
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
        }
        //        .navigationDestination(for: Team.self) { team in
        //            TeamDetailView(team: team)
        //        }
        .navigationTitle("Teams")
        //        .toolbar {
        //            ToolbarItem {
        //                Menu {
        //                    DisplayModeMenuButtonView(displayMode: .light)
        //                    DisplayModeMenuButtonView(displayMode: .dark)
        //                    DisplayModeMenuButtonView(displayMode: .system)
        //                } label: {
        //                    Label("Display mode", systemImage: userSettings.getDisplayModeIconName())
        //                }
        //            }
        //
        //            ToolbarItemGroup(placement: .bottomBar) {
        //                GroupingDialogButtonView(showingDialg: $showingGroupingDialog)
        //            }
        //        }
        //        .confirmationDialog("Change team grouping", isPresented: $showingGroupingDialog) {
        //            GroupingDialogChoiceView(grouping: .pool, showingList: $showingList)
        //            GroupingDialogChoiceView(grouping: .country, showingList: $showingList)
        //            GroupingDialogChoiceView(grouping: .seeding, showingList: $showingList)
        //            GroupingDialogChoiceView(grouping: .none, showingList: $showingList)
        //        }
    }
}


struct SeasonDetailView_Previews: PreviewProvider {
    
    static var coreDataController = CoreDataController(inMemory: true)
    
    static var databaseInitializer = DatabaseInitializer()
    
    static var previews: some View {
        NavigationStack {
            SeasonDetailView(season: databaseInitializer.seasons[2023, default: Season(context: coreDataController.mainContext, winYear: 1970, city: "Test", stadium: "test")])
                .environment(\.managedObjectContext, coreDataController.mainContext)
                .environmentObject(coreDataController)
            
        }
        .onAppear {
            coreDataController.performAndSave { moc in
                databaseInitializer.initialize(moc: moc)
            }
        }
    }
}
