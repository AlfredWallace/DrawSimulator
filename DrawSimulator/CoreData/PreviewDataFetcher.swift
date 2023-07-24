//
//  PreviewDataFetcher.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/06/2023.
//

import Foundation
import CoreData

struct PreviewDataFetcher {

    enum PreviewDataError: Error {
        case notFound
    }

    static func fetchData<T: NSManagedObject>(for type: T.Type, withPredicate predicate: NSPredicate? = nil) -> T {

        let moc = CoreDataController.preview.mainContext
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.fetchLimit = 1

        if let predicate {
            request.predicate = predicate
        }

        do {
            let results = try moc.fetch(request)

            guard let firstElement = results.first else {
                throw PreviewDataError.notFound
            }

            return firstElement
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
