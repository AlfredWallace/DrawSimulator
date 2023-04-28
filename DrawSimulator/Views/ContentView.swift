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
                ZStack {
                    Rectangle()
                        .fill(Color.defaultBackground.gradient)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        ForEach(seasons) { season in
                            CardView {
                                NavigationLink(value: season) {
                                    VStack {
                                        Text(season.stadium)
                                            .font(.custom(Fonts.ElMessiri.bold.rawValue, size: CGFloat(20), relativeTo: .caption))
                                        
                                        Text(season.city)
                                            .font(.custom(Fonts.ElMessiri.bold.rawValue, size: CGFloat(80), relativeTo: .largeTitle))
                                        
                                        Text("\(String(season.winYear - 1)) - \(String(season.winYear))")
                                            .font(.custom(Fonts.Chillax.bold.rawValue, size: CGFloat(40), relativeTo: .largeTitle))
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                    }
                }
                .navigationTitle("Seasons")
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
    static var coreDataController = CoreDataController()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, coreDataController.mainContext)
            .environmentObject(coreDataController)
    }
}
