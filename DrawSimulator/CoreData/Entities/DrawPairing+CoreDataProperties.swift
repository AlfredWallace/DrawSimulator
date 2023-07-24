//
//  DrawPairing+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 10/06/2023.
//
//

import Foundation
import CoreData

extension DrawPairing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrawPairing> {
        return NSFetchRequest<DrawPairing>(entityName: DrawPairing.entityName)
    }

    @NSManaged public var count: Int16
    @NSManaged public var season: Season?
    @NSManaged public var seededTeam: Team?
    @NSManaged public var unseededTeam: Team?

}

extension DrawPairing: Identifiable {

}
