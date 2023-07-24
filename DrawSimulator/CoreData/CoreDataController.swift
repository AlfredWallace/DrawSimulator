//
//  CoreDataController.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//

import CoreData
import SwiftUI

struct CoreDataController {
    static let shared = CoreDataController()
    
    static let preview: CoreDataController = {
        let controller = CoreDataController(inMemory: true)
        let moc = controller.mainContext
        let databaseInitializer = DatabaseInitializer()
        databaseInitializer.makeSeason(moc, 2023)
        try? moc.save()
        
        return controller
    }()
    
    private let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DrawSimulator")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        mainContext = container.viewContext
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        backgroundContext.parent = mainContext
        
        mainContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true

        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func performInBackgroundContextAndWait(commit: Bool, operation: (NSManagedObjectContext) -> Void) {
        backgroundContext.performAndWait {
            operation(backgroundContext)
            
            if commit { save() }
        }
    }
    
    func save() {
        backgroundContext.performAndWait {
            if backgroundContext.hasChanges {
                do {
                    try backgroundContext.save()
                } catch {
                    print("Could not save the background context: \(error.localizedDescription)")
                }
            }
        }
        
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("Could not save the main context: \(error.localizedDescription)")
            }
        }
    }
}
