//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    let teams: [Team] = Bundle.main.jsonDecode("teams.json")
    let countries: [Country] = Bundle.main.jsonDecode("countries.json")
    
    private var countriesDict: [Int: Country] {
        var result = [Int: Country]()
        
        countries.forEach {
            result[$0.id] = $0
        }
        
        return result
    }
    
    @StateObject var configuration = Configuration()
    
    private var groupingIconName: String {
        switch configuration.grouping {
            case .country:
                return "flag.square"
            default:
                return "list.dash"
        }
    }
    
    private var groupedTeams: [[Team]] {
        
        if configuration.grouping == .pool {
            return Array(Dictionary(grouping: teams, by: { $0.pool }).values).sorted {
                $0[0].pool < $1[0].pool
            }
        }
        
        return Array(Dictionary(grouping: teams, by: { $0.countryId }).values).sorted {
            if $0.count == $1.count {
                return countriesDict[$0[0].countryId]!.name < countriesDict[$1[0].countryId]!.name
            }
            
            return $0.count > $1.count
            
        }
    }
    
    private func getSectionTitle(_ team: Team) -> String {
        configuration.grouping == .pool ? team.pool :countriesDict[team.countryId]!.name
    }
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geo in
                    
                    let logoSize = geo.size.width * 0.12
                    let flagSize = geo.size.width * 0.07
                    
                    List(groupedTeams, id:\.self) { teams in
                        
                        Section(getSectionTitle(teams.first!)) {
                            
                            ForEach(teams) { team in
                                
                                NavigationLink {
                                    Text(team.name)
                                } label: {
                                    HStack {
                                        
                                        Image(team.name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: logoSize, height: logoSize)
                                        
                                        Text(team.name)
                                            .font(.title)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        
                                        if configuration.grouping == .pool {
                                            Image(countriesDict[team.countryId]!.name)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: flagSize, height: flagSize)
                                                .padding(.trailing)
                                        } else {
                                            HStack {
                                                Image(systemName: "\(team.pool.lowercased()).circle")
                                                    .foregroundColor(
                                                        Color(red: 0.54, green: 0.69, blue: 0.8)
                                                    )
                                                Image(systemName: "\(team.seeded ? "1" : "2").circle")
                                                    .foregroundColor(
                                                        team.seeded
                                                        ? Color(red: 0.0, green: 0.68, blue: 0.05)
                                                        : Color(red: 0.8, green: 0.4, blue: 0.1)
                                                    )
                                            }
                                            .font(.title3)
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
            }
            .navigationTitle("UEFA CL Draw")
            .toolbar {
                ToolbarItem {
                    Button {
                        configuration.setGrouping(configuration.grouping == .country ? .pool : .country)
                    } label: {
                        Label("Grouping", systemImage: groupingIconName)
                            .font(.title2)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
