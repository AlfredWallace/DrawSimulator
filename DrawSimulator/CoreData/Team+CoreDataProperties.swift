//
//  Team+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    enum Pool: String {
        case A = "A"
        case none = ""
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    var nonoptName: String {
        name ?? ""
    }
    
    @NSManaged public var abbreviation: String?
    var nonoptAbbreviation: String {
        abbreviation ?? ""
    }
    
    @NSManaged public var seeded: Bool
    @NSManaged public var association: Association?
    
    @NSManaged private var pool: String?
    var enumPool: Pool {
        get {
            if let pool = pool {
                return Pool(rawValue: pool) ?? .none
            }
            
            return .none
        }
        set {
            pool = newValue.rawValue
        }
    }
}

extension Team : Identifiable {

}
