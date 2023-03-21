//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    let teams: [Team] = Bundle.main.jsonDecode("teams.json")
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                List(teams) { team in
                    NavigationLink {
                        Text(team.name)
                    } label: {
                        HStack {
                            Image(team.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.12)
                            
                            Text(team.name)
                                .font(.largeTitle)
                                .padding(.leading)
                        }
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
