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
    @StateObject private var draws: Draws
    
    init(coreDataController: CoreDataController) {
        NavigationTheme.navigationBarColors()
        self._draws = StateObject(wrappedValue: Draws(coreDataController: coreDataController))
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
                .scrollIndicators(.hidden)
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
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(coreDataController: CoreDataController.preview)
            .environment(\.managedObjectContext, CoreDataController.preview.mainContext)
    }
}

