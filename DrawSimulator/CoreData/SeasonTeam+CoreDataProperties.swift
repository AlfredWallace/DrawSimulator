//
//  SeasonTeam+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 12/01/2023.
//
//

import Foundation
import CoreData


extension SeasonTeam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeasonTeam> {
        return NSFetchRequest<SeasonTeam>(entityName: "SeasonTeam")
    }

    @NSManaged public var pool: Int16
    @NSManaged public var seeded: Bool
    @NSManaged public var team: Team?
    @NSManaged public var season: Season?

}

extension SeasonTeam : Identifiable {

}
