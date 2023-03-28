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
    
    enum Grouping {
        case pool, country
    }
    
    @State private var grouping = Grouping.pool
    
    private var groupingIconName: String {
        switch grouping {
            case .country:
                return "flag.square"
            default:
                return "list.dash"
        }
    }
    
    private var groupedTeams: [[Team]] {
        
        if grouping == .pool {
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
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geo in
                    
                    let imgSize = geo.size.width * 0.12
                    
                    List(groupedTeams, id:\.self) { teams in
                        
                        Section(grouping == .pool ? teams.first!.pool : countriesDict[teams.first!.countryId]!.name) {
                            
                            ForEach(teams) { team in
                                
                                NavigationLink {
                                    Text(team.name)
                                } label: {
                                    HStack {
                                        
                                        Image(team.name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: imgSize, height: imgSize)
                                        
                                        Text(team.name)
                                            .font(.title)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        
                                        // todo: use this in the "by country" view later
                                        //                                    Image(systemName: "\(team.seeded ? "1" : "2").circle")
                                        //                                        .font(.title3)
                                        //                                        .foregroundColor(.gray)
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
                        grouping = grouping == .country ? .pool : .country
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
