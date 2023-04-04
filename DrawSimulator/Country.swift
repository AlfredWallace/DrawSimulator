//
//  Country.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/03/2023.
//

import Foundation

struct Country: Codable {
    let id: Int
    let name: String
    let shortName: String
    
    static let examples = [
        1: Country(id: 1, name: "France", shortName: "FRA"),
        2: Country(id: 2, name: "England", shortName: "ENG"),
        3: Country(id: 3, name: "Portugal", shortName: "POR"),
        4: Country(id: 4, name: "Belgium", shortName: "BEL"),
    ]
}
