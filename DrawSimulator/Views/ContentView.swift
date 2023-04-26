//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.winYear, order: .reverse)]) private var seasons: FetchedResults<Season>
    
    @StateObject private var userSettings = UserSettings()
    @StateObject private var geoSizeTracker = GeoSizeTracker()
    @StateObject private var draws = Draws()
    @StateObject private var databaseInitializer = DatabaseInitializer()
    
    @EnvironmentObject private var coreDataController: CoreDataController
    
    @State private var isFirstLaunch = true
    
    init() {
        NavigationTheme.navigationBarColors()
    }
    
    var body: some View {
        GeometryReader { geoWrapper in
            NavigationStack {
                ZStack {
                    Rectangle()
                        .fill(Color.pitchGreen.gradient)
                        .ignoresSafeArea()
                    ForEach(seasons) { season in
                        CardView {
                            NavigationLink(value: season) {
                                Text(String(season.winYear))
                            }
                        }
                    }
                }
                .navigationDestination(for: Season.self) { season in
                    TeamListView(season: season)
                }
            }
            .environmentObject(userSettings)
            .environmentObject(geoSizeTracker)
            .environmentObject(draws)
            .preferredColorScheme(userSettings.getColorScheme())
            .onAppear {
                geoSizeTracker.setSize(geoWrapper.size)
            }
        }
        .tint(.defaultText)
        .foregroundColor(.defaultText)
        .onAppear {
            if isFirstLaunch {
                coreDataController.performAndSave { moc in
                    databaseInitializer.initialize(moc: moc)
                }
                isFirstLaunch = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
