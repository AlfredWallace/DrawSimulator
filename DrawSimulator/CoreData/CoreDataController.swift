//
//  CoreDataController.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//

import CoreData
import SwiftUI

class CoreDataController: ObservableObject {
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
    
    func performAndSave(operation: (NSManagedObjectContext) -> Void) {
        backgroundContext.performAndWait {
            operation(backgroundContext)
            
            if backgroundContext.hasChanges {
                do {
                    try backgroundContext.save()
                } catch {
                    print("Could not save the background context error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
                }
            } else {
                print("Tried to save backgroundContext without any changes")
            }
            
            if mainContext.hasChanges {
                do {
                    try mainContext.save()
                } catch {
                    print("Could not save the main context error.localizedDescription:[\(error.localizedDescription)] ; error:[\(error)]")
                }
            } else {
                print("Tried to save mainContext without any changes")
            }
        }
    }
}
