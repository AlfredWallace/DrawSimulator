//
//  Season+CoreDataClass.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData

@objc(Season)
public class Season: NSManagedObject {
    
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
    
    public init(context: NSManagedObjectContext, winYear: Int, city: String, stadium: String, teamPools: NSSet? = []) {
        let entity = NSEntityDescription.entity(forEntityName: "Season", in: context)!
        super.init(entity: entity, insertInto: context)
        self.winYear = Int16(winYear)
        self.city = city
        self.stadium = stadium
        self.teamPools = teamPools
    }
}
