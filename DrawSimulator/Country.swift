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
    
    static let example = Country(id: 1, name: "France", shortName: "FRA")
}
