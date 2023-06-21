//
//  UserSetting+CoreDataClass.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//
//

import Foundation
import CoreData

@objc(UserSetting)
public class UserSetting: NSManagedObject {
    
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

    public init(context: NSManagedObjectContext, settingKey: String, settingValue: String) {
        let entity = NSEntityDescription.entity(forEntityName: UserSetting.entityName, in: context)!
        super.init(entity: entity, insertInto: context)
        self.settingKey = settingKey
        self.settingValue = settingValue
    }
}
