//
//  SeasonTeam+CoreDataClass.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData

@objc(SeasonTeam)
public class SeasonTeam: NSManagedObject {

    @available(*, unavailable)
    public init() {
        fatalError("Use the custom properties initializer")
    }

    @available(*, unavailable)
    public init(context: NSManagedObjectContext) {
        fatalError("Use the custom properties initializer")
    }

    @objc
    override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public init(context: NSManagedObjectContext, poolName: String, seeded: Bool, season: Season? = nil, team: Team? = nil) {
        let entity = NSEntityDescription.entity(forEntityName: SeasonTeam.entityName, in: context)!
        super.init(entity: entity, insertInto: context)
        self.poolName = poolName
        self.seeded = seeded
        self.season = season
        self.team = team
    }
}
