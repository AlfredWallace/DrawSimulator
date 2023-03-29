//
//  Configuration.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation

class Configuration: Codable, ObservableObject {
    
    enum Grouping: String, Codable {
        case pool, country
    }
    
    var grouping = Grouping.pool
}
