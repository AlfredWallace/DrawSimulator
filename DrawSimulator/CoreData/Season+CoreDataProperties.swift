//
//  Season+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 12/01/2023.
//
//

import Foundation
import CoreData


extension Season {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Season> {
        return NSFetchRequest<Season>(entityName: "Season")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var endYear: Int16
    @NSManaged public var backgroundPath: String?
    @NSManaged public var editable: Bool
    @NSManaged public var seasonTeams: NSSet?

}
// MARK: Generated accessors for seasonTeams
extension Season {

    @objc(addSeasonTeamsObject:)
    @NSManaged public func addToSeasonTeams(_ value: SeasonTeam)

    @objc(removeSeasonTeamsObject:)
    @NSManaged public func removeFromSeasonTeams(_ value: SeasonTeam)

    @objc(addSeasonTeams:)
    @NSManaged public func addToSeasonTeams(_ values: NSSet)

    @objc(removeSeasonTeams:)
    @NSManaged public func removeFromSeasonTeams(_ values: NSSet)

}

extension Season : Identifiable {

}
