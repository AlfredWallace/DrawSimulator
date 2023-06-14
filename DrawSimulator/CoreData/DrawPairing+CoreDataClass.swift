//
//  DrawPairing+CoreDataClass.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 10/06/2023.
//
//

import Foundation
import CoreData

@objc(DrawPairing)
public class DrawPairing: NSManagedObject {
    
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
    
    public init(context: NSManagedObjectContext, count: Int16, season: Season? = nil, seededTeam: Team? = nil, unseededTeam: Team? = nil) {
        let entity = NSEntityDescription.entity(forEntityName: DrawPairing.entityName, in: context)!
        super.init(entity: entity, insertInto: context)
        self.count = count
        self.season = season
        self.seededTeam = seededTeam
        self.unseededTeam = unseededTeam
    }
}
