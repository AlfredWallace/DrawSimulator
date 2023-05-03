//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject private var coreDataController: CoreDataController
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.winYear, order: .reverse)]) private var seasons: FetchedResults<Season>
    
    @StateObject private var userSettings = UserSettings()
    @StateObject private var geoSizeTracker = GeoSizeTracker()
    @StateObject private var draws = Draws()
    @StateObject private var databaseInitializer = DatabaseInitializer()
    
    @State private var isFirstLaunch = true
    
    init() {
        NavigationTheme.navigationBarColors()
    }
    
    var body: some View {
        GeometryReader { geoWrapper in
            NavigationStack {
                ScrollView {
                    ForEach(seasons) { season in
                        CardView {
                            NavigationLink(value: season) {
                                VStack {
                                    Text(season.stadium)
                                        .sportFont(.body)
                                    Text(season.city)
                                        .sportFont(.largeTitle, multiplier: 2.4)
                                        .dynamicTypeSize(.xSmall ... .large)
                                    Text(String(season.winYear))
                                        .sportFont(.largeTitle, multiplier: 1.4)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                }
                .background {
                    Rectangle()
                        .fill(Color.pitchGreen.gradient)
                        .ignoresSafeArea()
                }
                .navigationTitle("Seasons")
                .navigationDestination(for: Season.self) { season in
                    SeasonDetailView(season: season)
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
    static var coreDataController = CoreDataController(inMemory: true)
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, coreDataController.mainContext)
            .environmentObject(coreDataController)
    }
}
