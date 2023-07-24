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

    @AppStorage("appFirstLaunch") private var appFirstLaunch = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataController.shared.mainContext)
                .environmentObject(Draws(coreDataController: CoreDataController.shared))
                .onAppear {
                    if appFirstLaunch {
                        CoreDataController.shared.performInBackgroundContextAndWait(commit: true) { moc in
                            let databaseInitializer = DatabaseInitializer()
                            databaseInitializer.makeSeason(moc, 2023)
                        }
                        appFirstLaunch = false
                    }
                }
        }
    }
}
