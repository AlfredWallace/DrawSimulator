//
//  Team.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 19/03/2023.
//

import Foundation

struct Team: Codable, Identifiable {
    let id: Int
    let name: String
    let shortName: String
    let seeded: Bool
    let countryId: Int
}
