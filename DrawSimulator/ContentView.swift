//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List(countries) {
                Text($0.name ?? "unknown name")
            }
        }
            .onAppear(perform: initializeCoreData)
    }
    
    func initializeCoreData() {
        let france = Country(context: moc)
        france.name = "France"
        france.shortName = "FRA"
        
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print("Could not save initialization: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
