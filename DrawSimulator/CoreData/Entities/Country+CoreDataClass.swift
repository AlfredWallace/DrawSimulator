//
//  Country+CoreDataClass.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 22/04/2023.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {

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

    public init(context: NSManagedObjectContext, name: String, shortName: String, teams: NSSet? = []) {
        let entity = NSEntityDescription.entity(forEntityName: Country.entityName, in: context)!
        super.init(entity: entity, insertInto: context)
        self.name = name
        self.shortName = shortName
        self.teams = teams
    }

}
