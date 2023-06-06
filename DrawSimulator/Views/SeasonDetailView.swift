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
//    @SectionedFetchRequest private var teamPoolsByCountry: SectionedFetchResults<String, TeamPool>
    
    init(season: Season) {
        self.season = season
        
        _teamPoolsByPool = SectionedFetchRequest(
            sectionIdentifier: \.name,
            sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.seeded, order: .reverse)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _teamPoolsBySeeding = SectionedFetchRequest(
            sectionIdentifier: \.seededString,
            sortDescriptors: [SortDescriptor(\.seeded, order: .reverse), SortDescriptor(\.name)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
//        _teamPoolsByCountry = SectionedFetchRequest(
//            sectionIdentifier: \.team?.country,
//            sortDescriptors: [SortDescriptor(\.name), SortDescriptor(\.seeded, order: .reverse)],
//            predicate: NSPredicate(format: "season == %@", season)
//        )
    }
    
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
//        private var teamPools: SectionedFetchResults<String, TeamPool> {
//            switch userSettings.data.grouping {
////                case .country:
////                    return teamsGroupedByCountry
////                case .pool:
//                default:
//                    return teamPoolsBySeeding
////                case .seeding:
////                default:
////                    return teamPoolsBySeeding
////                default:
////                    return teamsUngrouped
//            }
//        }
//
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            VStack {
                if showingList {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(teamPoolsBySeeding) { section in
                                
                                CardView(hasHeaderDivier: true) {
                                    VStack(spacing: 10) {
                                        ForEach(section) { teamPool in
                                            NavigationLink(value: teamPool) {
                                                HStack {
                                                    Group {
                                                        if let team = teamPool.team {
                                                            TeamLabelView(team: team)
                                                        } else {
                                                            Text("Error")
                                                            Spacer()
                                                        }
                                                    }
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
//                    .onAppear {
//                        print(true.description)
//                    }
                }
            }
        }
        //        .navigationDestination(for: Team.self) { team in
        //            TeamDetailView(team: team)
        //        }
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

