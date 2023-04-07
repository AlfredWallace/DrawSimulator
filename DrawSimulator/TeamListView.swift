//
//  TeamListView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 07/04/2023.
//

import SwiftUI

struct TeamListView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    
    let teams: [Team] = Bundle.main.jsonDecode("teams.json")
    let countries: [Country] = Bundle.main.jsonDecode("countries.json")
    
    private var countriesDict: [Int: Country] {
        var result = [Int: Country]()
        
        countries.forEach {
            result[$0.id] = $0
        }
        
        return result
    }
    
    private var groupingIconName: String {
        switch userSettings.grouping {
            case .country:
                return "flag.square"
            default:
                return "list.dash"
        }
    }
    
    private var teamsGroupedByPool: [[Team]] {
        Array(Dictionary(grouping: teams, by: { $0.pool }).values).sorted {
            $0[0].pool < $1[0].pool
        }
    }
    
    private var teamsGroupedByCountry: [[Team]] {
        
        // first we sort teams by name so that they appear sorted by name in each subarrays after the grouping
        let teamsByName = teams.sorted {
            $0.name < $1.name
        }
        
        // then we group teams by contry, and sort the groups by number of teams then country name
        return Array(Dictionary(grouping: teamsByName, by: { $0.countryId }).values).sorted { lhs, rhs in
            if lhs.count == rhs.count {
                return countriesDict[lhs[0].countryId]!.name < countriesDict[rhs[0].countryId]!.name
            }
            
            return lhs.count > rhs.count
            
        }
    }
    
    private var groupedTeams: [[Team]] {
        switch userSettings.grouping {
            case .pool:
                return teamsGroupedByPool
            default:
                return teamsGroupedByCountry
        }
    }
    
    
    var body: some View {
        GeometryReader { geo in
            
            List(groupedTeams, id: \.self) { teams in
                Section {
                    SectionTitleView(team: teams.first!, countriesDict: countriesDict)
                    
                    ForEach(teams) { team in
                        TeamLinkView(team: team, countriesDict: countriesDict, geo: geo)
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
            ToolbarItem {
                Button {
                    userSettings.setGrouping(userSettings.grouping == .country ? .pool : .country)
                } label: {
                    Label("Grouping", systemImage: groupingIconName)
                        .font(.title2)
                }
            }
        }
    }
}

//struct TeamListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamListView()
//    }
//}
