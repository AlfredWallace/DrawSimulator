//
//  CoreDataController.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//

import CoreData
import SwiftUI

class CoreDataController {
    static let shared = CoreDataController() // singleton
    
    static let preview: CoreDataController = {
        var result = CoreDataController(inMemory: true)
        result.performInBackground(commit: true) { moc in
            DatabaseInitializer.makeSeason(moc, 2023)
        }
        
        return result
    }()
    
    private let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "DrawSimulator")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        self.mainContext = container.viewContext
        self.backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        container.loadPersistentStores { description, error in

            self.mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            self.backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            self.backgroundContext.parent = self.mainContext
            
            self.mainContext.automaticallyMergesChangesFromParent = true
            self.backgroundContext.automaticallyMergesChangesFromParent = true

            if let error {
                print("Core Data failed to load. error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
            }
        }
    }
    
    func performInBackground(commit: Bool, operation: (NSManagedObjectContext) -> Void) {
        backgroundContext.performAndWait {
            operation(backgroundContext)
            
            if commit { save() }
        }
    }
    
    private func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Could not save the background context error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
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
