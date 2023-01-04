//
//  Association+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//
//

import Foundation
import CoreData


extension Association {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Association> {
        return NSFetchRequest<Association>(entityName: "Association")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var teams: NSSet?

    var nonoptName: String {
        name ?? ""
    }
    
    var teamsArray: [Team] {
        let set = teams as? Set<Team> ?? []
        return set.sorted {
            $0.nonoptName < $1.nonoptName
        }
    }
}

// MARK: Generated accessors for teams
extension Association {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: Team)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: Team)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)

}

extension Association : Identifiable {

}
