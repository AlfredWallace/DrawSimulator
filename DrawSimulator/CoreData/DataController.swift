//
//  DrawSimulatorDataController.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DrawSimulatorDataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Could not load CoreData: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
