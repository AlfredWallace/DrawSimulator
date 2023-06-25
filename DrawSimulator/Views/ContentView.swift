//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject private var draws: Draws
    
    @StateObject private var userSettings = UserSettings()
    @StateObject private var geoSizeTracker = GeoSizeTracker()
    
    init() {
        CustomTheme.setColors()
    }
    
    var body: some View {
        
        ZStack {
            GeometryReader { geoWrapper in
                Spacer()
                    .onAppear {
                        geoSizeTracker.setSize(geoWrapper.size)
                    }
            }
            
            TabView {
                SeasonListView()
                    .tabItem {
                        Label("Seasons", systemImage: "soccerball")
                    }
                    .badge(draws.isRunning ? Text("R") : nil)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "slider.horizontal.3")
                    }
                
                AboutView()
                    .tabItem {
                        Label("About", systemImage: "info.square")
                    }
            }
            .environmentObject(userSettings)
            .environmentObject(geoSizeTracker)
        }
        .tint(.pitchGreen)
        .foregroundColor(.defaultText)
    }
}

struct ContentView_Previews: PreviewProvider {

    static var userSettings = UserSettings()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataController.preview.mainContext)
            .environmentObject(userSettings)
            .environmentObject(Draws(coreDataController: CoreDataController.preview))
    }
}

