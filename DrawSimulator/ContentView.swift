//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    let teams: [Team] = Bundle.main.jsonDecode("teams.json")
    
    var teamsByPool: [[Team]] {
        Array(Dictionary(grouping: teams, by: { $0.pool }).values).sorted {
            $0[0].pool < $1[0].pool
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                
                let imgSize = geo.size.width * 0.12
                
                List(teamsByPool, id:\.self) { teams in
                    
                    Section(teams.first!.pool) {
                        
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
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle("UEFA CL Draw")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
