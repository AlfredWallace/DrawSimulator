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
    @NSManaged public var teamPools: NSSet?
    
    public var teamPoolsArray: [TeamPool] {
        let teamPoolsSet = teamPools as? Set<TeamPool> ?? []
        return teamPoolsSet.sorted { $0.name < $1.name }
    }

    @objc public var winYearString: String {
        String(winYear)
    }
}

// MARK: Generated accessors for teamPools
extension Season {

    @objc(addTeamPoolsObject:)
    @NSManaged public func addToTeamPools(_ value: TeamPool)

    @objc(removeTeamPoolsObject:)
    @NSManaged public func removeFromTeamPools(_ value: TeamPool)

    @objc(addTeamPools:)
    @NSManaged public func addToTeamPools(_ values: NSSet)

    @objc(removeTeamPools:)
    @NSManaged public func removeFromTeamPools(_ values: NSSet)

}

extension Season : Identifiable {

}
