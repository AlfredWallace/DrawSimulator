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
    
    @StateObject private var geoSizeTracker = GeoSizeTracker()
    
    @EnvironmentObject private var userSettings: UserSettings
    @EnvironmentObject private var draws: Draws
    
    init() {
        NavigationTheme.navigationBarColors()
    }
    
    var body: some View {
        
        ZStack {
            GeometryReader { geoWrapper in
                Spacer()
                    .onAppear {
                        geoSizeTracker.setSize(geoWrapper.size)
                    }
            }
            
            NavigationStack {
                
                List(seasons) { season in
                    NavigationLink(value: season) {
                        VStack(alignment: .leading, spacing: 0) {

                            Text(String(season.winYear))
                                .sportFont(.largeTitle, multiplier: 2.5)
                                .dynamicTypeSize(.xSmall ... .large)

                            Group {
                                Text(season.stadium)
                                Text(season.city)
                            }
                            .sportFont(.body)
                        }
                    }
                    .listRowSeparatorTint(.pitchGreen)
                }
                
                .navigationTitle("Seasons")
                .navigationDestination(for: Season.self) { season in
                    SeasonDetailView(season: season)
                }
                .toolbar {
                    ToolbarItem {
                        Menu {
                            DisplayModeMenuButtonView(displayMode: .light)
                            DisplayModeMenuButtonView(displayMode: .dark)
                            DisplayModeMenuButtonView(displayMode: .system)
                        } label: {
                            Label("Display mode", systemImage: userSettings.getDisplayModeIconName())
                        }
                    }
                }
            }
            .environmentObject(geoSizeTracker)
            .environmentObject(draws)
            .preferredColorScheme(userSettings.getColorScheme())
        }
        .tint(.defaultText)
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

