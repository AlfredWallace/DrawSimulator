//
//  CoreDataController.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//

import CoreData
import SwiftUI

struct CoreDataController {
    static let shared = CoreDataController() // singleton
    
    static let preview: CoreDataController = {
        var result = CoreDataController(inMemory: true)
        result.performInBackgroundContextAndWait(commit: true) { moc in
            DatabaseInitializer.makeSeason(moc, 2023)
        }
        
        return result
    }()
    
    private let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
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

        container.loadPersistentStores { description, error in

            if let error {
                print("Core Data failed to load. error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
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
                    print("Could not save the background context error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
                }
            }
        }
        
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("Could not save the main context error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
            }
        }
    }
}
