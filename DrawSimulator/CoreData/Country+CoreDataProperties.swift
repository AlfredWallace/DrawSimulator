//
//  Country+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var shortName: String?
    @NSManaged public var teams: NSSet?

    public var nameProxy: String {
        name ?? "unknown name"
    }
    
    public var shortNameProxy: String {
        shortName ?? "unknown short name"
    }
    
    public var teamsProxy: [Team] {
        let teamsSet = teams as? Set<Team> ?? []
        return teamsSet.sorted { $0.nameProxy < $1.nameProxy }
    }
}

// MARK: Generated accessors for teams
extension Country {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: Team)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: Team)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)

}

extension Country : Identifiable {

}
