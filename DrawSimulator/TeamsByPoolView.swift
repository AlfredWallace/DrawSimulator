//
//  TeamsByPoolView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/03/2023.
//

import SwiftUI

struct TeamsByPoolView: View {
    let teams: [Team]
    
    var teamsByPool: [[Team]] {
        Array(Dictionary(grouping: teams, by: { $0.pool }).values).sorted {
            $0[0].pool < $1[0].pool
        }
    }
    
    var body: some View {
        
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
}

//struct TeamsByPoolView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamsByPoolView()
//    }
//}
