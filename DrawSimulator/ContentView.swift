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
        List(teams) { team in
            Text(team.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
