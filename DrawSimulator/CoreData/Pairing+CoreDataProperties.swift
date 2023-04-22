//
//  Pairing+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData


extension Pairing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pairing> {
        return NSFetchRequest<Pairing>(entityName: "Pairing")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var seededTeamId: Int16
    @NSManaged public var unseededTeamId: Int16
    @NSManaged public var count: Int16

}

extension Pairing : Identifiable {

}
