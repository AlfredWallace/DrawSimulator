//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var teams: FetchedResults<Team>
    
    var body: some View {
        VStack {
            List(teams) {
                Text($0.nonoptName)
            }
            
            Spacer()
            
            Button {
                resetTeams()
            } label: {
                Text("Reset Teams")
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
        }
    }
    
    func resetTeams() {
        for team in teams {
            moc.delete(team)
        }
        
        let team = Team(context: moc)
        team.name = "Paris Saint-Germain"
        team.abbreviation = "PSG"
        team.enumPool = .A
        team.seeded = false
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
