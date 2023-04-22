//
//  TeamPool+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData


extension TeamPool {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamPool> {
        return NSFetchRequest<TeamPool>(entityName: "TeamPool")
    }

    @NSManaged public var seeded: Bool
    @NSManaged public var name: String?
    @NSManaged public var team: Team?
    @NSManaged public var season: Season?

}

extension TeamPool : Identifiable {

}
