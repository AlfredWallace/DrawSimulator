//
//  Team.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 19/03/2023.
//

import Foundation
import SwiftUI

struct Team: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let shortName: String
    let seeded: Bool
    let countryId: Int
    let pool: String
    
    var poolImage: some View {
        Image(systemName: "\(pool.lowercased()).circle")
            .foregroundColor(.darkGray)
    }
    
    var seededImage: some View {
        Image(systemName: "\(seeded ? "1" : "2").circle")
            .foregroundColor(seeded ? .accentColor : .red)
    }
    
    static let examples = [
        Team(id: 1, name: "Paris", shortName: "PSG", seeded: false, countryId: 1, pool: "A"),
        Team(id: 2, name: "Tottenham", shortName: "TOT", seeded: true, countryId: 2, pool: "A"),
        Team(id: 3, name: "Benfica", shortName: "BEN", seeded: true, countryId: 3, pool: "B"),
        Team(id: 4, name: "Club Brugge", shortName: "CBU", seeded: false, countryId: 4, pool: "B"),
        Team(id: 5, name: "Leipzig", shortName: "LEI", seeded: false, countryId: 5, pool: "C"),
    ]
}
