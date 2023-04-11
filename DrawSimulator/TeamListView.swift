//
//  TeamListView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 07/04/2023.
//

import SwiftUI

struct TeamListView: View {
    
    @State private var showingGroupingDialog = false
    
    @EnvironmentObject private var userSettings: UserSettings
    
    private var groupingLabelStrings: (title: String, icon: String) {
        switch userSettings.grouping {
            case .country:
                return ("Grouped by country", "flag")
            case .seeding:
                return ("Grouped by seeding", "checklist")
            case .pool:
                return ("Grouped by pool", "list.bullet.below.rectangle")
            default:
                return ("Ungrouped", "list.dash")
        }
    }
    
    private var teamsGroupedByPool: [[Team]] {
        Array(Dictionary(grouping: SharedConstants.teams, by: { $0.pool }).values).sorted {
            $0[0].pool < $1[0].pool
        }
    }
    
    private var teamsGroupedByCountry: [[Team]] {
        
        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
        let teamsByName = SharedConstants.teams.sorted {
            $0.name < $1.name
        }
        
        // then we group teams by contry, and sort the groups by number of teams then country name
        return Array(Dictionary(grouping: teamsByName, by: { $0.countryId }).values).sorted { lhs, rhs in
            if lhs.count == rhs.count {
                return SharedConstants.countries[lhs[0].countryId]!.name < SharedConstants.countries[rhs[0].countryId]!.name
            }
            
            return lhs.count > rhs.count
            
        }
    }
    
    private var teamsGroupedBySeeding: [[Team]] {
        
        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
        let teamsByName = SharedConstants.teams.sorted {
            $0.name < $1.name
        }
        
        // then we group teams by seeding, and sort the groups by putting the seeding teams first
        return Array(Dictionary(grouping: teamsByName, by: { $0.seeded }).values).sorted { lhs, _ in lhs.first!.seeded }
    }
    
    private var teamsUngrouped: [[Team]] {
        var result = [[Team]]()
        
        result.append(SharedConstants.teams.sorted {
            $0.name < $1.name
        })
        
        return result
    }
    
    private var groupedTeams: [[Team]] {
        switch userSettings.grouping {
            case .pool:
                return teamsGroupedByPool
            case .seeding:
                return teamsGroupedBySeeding
            case .country:
                return teamsGroupedByCountry
            default:
                return teamsUngrouped
        }
    }
    
    
    var body: some View {
        GeometryReader { geo in
            
            List(groupedTeams, id: \.self) { teams in
                Section {
                    TeamListSectionTitleView(team: teams.first!)
                    
                    ForEach(teams) { team in
                        TeamListLinkView(team: team, geo: geo)
                    }
                }
                .listRowBackground(Color.accentColor)
                .foregroundColor(.white)
            }
        }
        .navigationDestination(for: Team.self) { team in
            TeamDetailView(team: team)
        }
        .preferredColorScheme(.light)
        .navigationTitle("Teams")
        .toolbar {
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
            if userSettings.grouping != .pool {
                Button("Group by pool") { userSettings.setGrouping(.pool) }
            }
            
            if userSettings.grouping != .country {
                Button("Group by country") { userSettings.setGrouping(.country) }
            }
            
            if userSettings.grouping != .seeding {
                Button("Group by seeding") { userSettings.setGrouping(.seeding) }
            }
            
            if userSettings.grouping != .none {
                Button("Ungrouped") { userSettings.setGrouping(.none) }
            }
        }
    }
}
