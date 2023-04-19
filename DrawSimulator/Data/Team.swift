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
}
