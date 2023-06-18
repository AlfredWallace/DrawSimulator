//
//  DrawSimulatorApp.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI
import CoreData

@main
struct DrawSimulatorApp: App {
    
//    DO NOT DELETE : uncomment to log the real font names and use them in the Font class
//    init() {
//        for family in UIFont.familyNames {
//            print(family)
//            for names in UIFont.fontNames(forFamilyName: family){
//                print("== \(names)")
//            }
//        }
//    }
    
    @State private var isFirstLaunch = true
    @StateObject private var coreDataController = CoreDataController.shared
    @StateObject private var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView(coreDataController: coreDataController)
                .environment(\.managedObjectContext, coreDataController.mainContext)
                .environmentObject(userSettings)
                .onAppear {
                    if isFirstLaunch {
                        coreDataController.performInBackgroundContextAndWait(commit: true) { moc in
                            DatabaseInitializer.makeSeason(moc, 2023)
                        }
                        isFirstLaunch = false
                    }
                }
        }
    }
}
