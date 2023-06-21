//
//  UserSetting+CoreDataProperties.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//
//

import Foundation
import CoreData


extension UserSetting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSetting> {
        return NSFetchRequest<UserSetting>(entityName: UserSetting.entityName)
    }

    @NSManaged public var settingKey: String
    @NSManaged public var settingValue: String

}

extension UserSetting : Identifiable {

}
