//
//  Team+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 12/01/2023.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var shortName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var logoPath: String?
    @NSManaged public var country: Country?
    @NSManaged public var seasonTeams: NSSet?

}

// MARK: Generated accessors for seasonTeams
extension Team {

    @objc(addSeasonTeamsObject:)
    @NSManaged public func addToSeasonTeams(_ value: SeasonTeam)

    @objc(removeSeasonTeamsObject:)
    @NSManaged public func removeFromSeasonTeams(_ value: SeasonTeam)

    @objc(addSeasonTeams:)
    @NSManaged public func addToSeasonTeams(_ values: NSSet)

    @objc(removeSeasonTeams:)
    @NSManaged public func removeFromSeasonTeams(_ values: NSSet)

}

extension Team : Identifiable {

}
