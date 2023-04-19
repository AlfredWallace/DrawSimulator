//
//  TeamListView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 07/04/2023.
//

import SwiftUI

struct TeamListView: View {
    
    @State private var showingGroupingDialog = false
    @State private var showingList = true
    
    @EnvironmentObject private var userSettings: UserSettings
    
    private var groupingLabelStrings: (title: String, icon: String) {
        switch userSettings.data.grouping {
            case .country:
                return ("Grouped by country", "flag")
            case .pool:
                return ("Grouped by pool", "list.bullet.below.rectangle")
            case .seeding:
                return ("Grouped by seeding", "checklist")
            default:
                return ("Ungrouped", "list.dash")
        }
    }
    
    private var teamsGroupedByPool: [[Team]] {
        Array(Dictionary(grouping: Teams.data, by: { $0.pool }).values).sorted {
            $0[0].pool < $1[0].pool
        }
    }
    
    private var teamsGroupedByCountry: [[Team]] {
        
        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
        let teamsByName = Teams.data.sorted {
            $0.name < $1.name
        }
        
        // then we group teams by contry, and sort the groups by number of teams then country name
        return Array(Dictionary(grouping: teamsByName, by: { $0.countryId }).values).sorted { lhs, rhs in
            if lhs.count == rhs.count {
                return Countries.data[lhs[0].countryId]!.name < Countries.data[rhs[0].countryId]!.name
            }
            
            return lhs.count > rhs.count
            
        }
    }
    
    private var teamsGroupedBySeeding: [[Team]] {
        
        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
        let teamsByName = Teams.data.sorted {
            $0.name < $1.name
        }
        
        // then we group teams by seeding, and sort the groups by putting the seeding teams first
        return Array(Dictionary(grouping: teamsByName, by: { $0.seeded }).values).sorted { lhs, _ in lhs.first!.seeded }
    }
    
    private var teamsUngrouped: [[Team]] {
        var result = [[Team]]()
        
        result.append(Teams.data.sorted {
            $0.name < $1.name
        })
        
        return result
    }
    
    private var groupedTeams: [[Team]] {
        switch userSettings.data.grouping {
            case .country:
                return teamsGroupedByCountry
            case .pool:
                return teamsGroupedByPool
            case .seeding:
                return teamsGroupedBySeeding
            default:
                return teamsUngrouped
        }
    }
    
    var body: some View {
        ScrollView {
            if showingList {
                VStack(spacing: 20) {
                    ForEach(groupedTeams, id: \.self) { teamGroup in
                        
                        CardView(hasHeaderDivier: true) {
                            VStack(spacing: 10) {
                                ForEach(teamGroup) { team in
                                    TeamLinkView(team: team)
                                }
                            }
                            .padding(.vertical, 5)
                        } header: {
                            TeamGroupTitleView(team: teamGroup.first!)
                                .font(.title2.bold())
                        }
                    }
                }
                .padding(.horizontal)
                .transition(.move(edge: .bottom))
            }
        }
        .scrollIndicators(.hidden)
        .navigationDestination(for: Team.self) { team in
            TeamDetailView(team: team)
        }
        .navigationTitle("Teams")
        .toolbar {
            ToolbarItem {
                Menu {
                    DisplayModeMenuButtonView(displayMode: .light)
                    DisplayModeMenuButtonView(displayMode: .dark)
                    DisplayModeMenuButtonView(displayMode: .system)
                } label: {
                    Label("Display mode", systemImage: userSettings.getDisplayModeIconName())
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showingGroupingDialog = true
                } label: {
                    Label(groupingLabelStrings.title, systemImage: groupingLabelStrings.icon)
                        .labelStyle(.titleAndIcon)
                        .font(.title2)
                }
            }
        }
        .confirmationDialog("Change team grouping", isPresented: $showingGroupingDialog) {
            GroupingDialogButtonView(grouping: .pool, showingList: $showingList)
            GroupingDialogButtonView(grouping: .country, showingList: $showingList)
            GroupingDialogButtonView(grouping: .seeding, showingList: $showingList)
            GroupingDialogButtonView(grouping: .none, showingList: $showingList)
        }
    }
}
