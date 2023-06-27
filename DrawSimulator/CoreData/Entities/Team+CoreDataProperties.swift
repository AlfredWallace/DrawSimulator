//
//  Team+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 10/06/2023.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: Team.entityName)
    }
    
    @NSManaged public var name: String
    @NSManaged public var shortName: String
    @NSManaged public var sortingName: String
    @NSManaged public var country: Country?
    @NSManaged public var seasonTeams: NSSet?
    @NSManaged public var seededDrawPairings: NSSet?
    @NSManaged public var unseededDrawPairings: NSSet?
    
    public var seasonTeamsArray: [SeasonTeam] {
        let seasonTeamsSet = seasonTeams as? Set<SeasonTeam> ?? []
        return seasonTeamsSet.sorted { $0.poolName < $1.poolName }
    }
    
    public var seededDrawPairingsArray: [DrawPairing] {
        let drawPairingsSet = seededDrawPairings as? Set<DrawPairing> ?? []
        return drawPairingsSet.sorted { $0.count < $1.count }
    }
    
    public var unseededDrawPairingsArray: [DrawPairing] {
        let drawPairingsSet = unseededDrawPairings as? Set<DrawPairing> ?? []
        return drawPairingsSet.sorted { $0.count < $1.count }
    }

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

// MARK: Generated accessors for seededDrawPairings
extension Team {

    @objc(addSeededDrawPairingsObject:)
    @NSManaged public func addToSeededDrawPairings(_ value: DrawPairing)

    @objc(removeSeededDrawPairingsObject:)
    @NSManaged public func removeFromSeededDrawPairings(_ value: DrawPairing)

    @objc(addSeededDrawPairings:)
    @NSManaged public func addToSeededDrawPairings(_ values: NSSet)

    @objc(removeSeededDrawPairings:)
    @NSManaged public func removeFromSeededDrawPairings(_ values: NSSet)

}

// MARK: Generated accessors for unseededDrawPairings
extension Team {

    @objc(addUnseededDrawPairingsObject:)
    @NSManaged public func addToUnseededDrawPairings(_ value: DrawPairing)

    @objc(removeUnseededDrawPairingsObject:)
    @NSManaged public func removeFromUnseededDrawPairings(_ value: DrawPairing)

    @objc(addUnseededDrawPairings:)
    @NSManaged public func addToUnseededDrawPairings(_ values: NSSet)

    @objc(removeUnseededDrawPairings:)
    @NSManaged public func removeFromUnseededDrawPairings(_ values: NSSet)

}

extension Team : Identifiable {

}
