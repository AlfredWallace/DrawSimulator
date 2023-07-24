//
//  SeasonTeam+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 25/04/2023.
//
//

import Foundation
import CoreData

extension SeasonTeam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeasonTeam> {
        return NSFetchRequest<SeasonTeam>(entityName: SeasonTeam.entityName)
    }

    @NSManaged public var poolName: String
    @NSManaged public var seeded: Bool
    @NSManaged public var season: Season?
    @NSManaged public var team: Team?

    @objc public var seededString: String {
        seeded ? "Seeded" : "Unseeded"
    }

    @objc public var fullPoolName: String {
        "Pool \(poolName)"
    }
}

extension SeasonTeam: Identifiable {

}
