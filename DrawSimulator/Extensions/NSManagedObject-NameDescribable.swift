//
//  NSManagedObject-NameDescribable.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 11/06/2023.
//

import CoreData
import Foundation

extension NSManagedObject {
    static var entityName: String { String(describing: self) }
}
