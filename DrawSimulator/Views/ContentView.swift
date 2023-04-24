//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(sortDescriptors: []) private var countries: FetchedResults<Country>
    
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
                    
                    TeamListView()
                    
                    VStack {
                        ForEach(countries) { country in
                            Text("\(country.nameProxy) (\(country.shortNameProxy))")
                        }
                    }
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
                    databaseInitializer.initCountries(moc: moc)
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
