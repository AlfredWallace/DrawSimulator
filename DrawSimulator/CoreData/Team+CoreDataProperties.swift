//
//  Team+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var name: String?
    @NSManaged public var shortName: String?
    @NSManaged public var pool: String?
    @NSManaged public var country: Country?
    @NSManaged public var teamPools: NSSet?

    public var nameProxy: String {
        name ?? "unknown name"
    }
    
    public var shortNameProxy: String {
        shortName ?? "unknown short name"
    }
    
    
}

// MARK: Generated accessors for teamPools
extension Team {

    @objc(addTeamPoolsObject:)
    @NSManaged public func addToTeamPools(_ value: TeamPool)

    @objc(removeTeamPoolsObject:)
    @NSManaged public func removeFromTeamPools(_ value: TeamPool)

    @objc(addTeamPools:)
    @NSManaged public func addToTeamPools(_ values: NSSet)

    @objc(removeTeamPools:)
    @NSManaged public func removeFromTeamPools(_ values: NSSet)

}

extension Team : Identifiable {

}
