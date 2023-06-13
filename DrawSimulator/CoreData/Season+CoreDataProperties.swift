//
//  Season+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData


extension Season {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Season> {
        return NSFetchRequest<Season>(entityName: Season.entityName)
    }

    @NSManaged public var winYear: Int16
    @NSManaged public var city: String
    @NSManaged public var stadium: String
    @NSManaged public var seasonTeams: NSSet?
    
    public var seasonTeamsArray: [SeasonTeam] {
        let seasonTeamSet = seasonTeams as? Set<SeasonTeam> ?? []
        return seasonTeamSet.sorted { $0.poolName < $1.poolName }
    }

    @objc public var winYearString: String {
        String(winYear)
    }
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
