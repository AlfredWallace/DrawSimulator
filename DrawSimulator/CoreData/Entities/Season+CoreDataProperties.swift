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
    @NSManaged public var drawPairings: NSSet?
    
    public var seasonTeamsArray: [SeasonTeam] {
        let seasonTeamsSet = seasonTeams as? Set<SeasonTeam> ?? []
        return seasonTeamsSet.sorted { $0.poolName < $1.poolName }
    }
    
    public var drawPairingsArray: [DrawPairing] {
        let drawPairingsSet = drawPairings as? Set<DrawPairing> ?? []
        return drawPairingsSet.sorted { $0.count < $1.count }
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

// MARK: Generated accessors for drawPairings
extension Season {
    
    @objc(addDrawPairingsObject:)
    @NSManaged public func addToDrawPairings(_ value: DrawPairing)
    
    @objc(removeDrawPairingsObject:)
    @NSManaged public func removeFromDrawPairings(_ value: DrawPairing)
    
    @objc(addDrawPairings:)
    @NSManaged public func addToDrawPairings(_ values: NSSet)
    
    @objc(removeDrawPairings:)
    @NSManaged public func removeFromDrawPairings(_ values: NSSet)
    
}

extension Season: Identifiable {

}
