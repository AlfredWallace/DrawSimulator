//
//  Teams.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 08/04/2023.
//

import Foundation

class Teams {
    static let data: [Team] = Bundle.main.jsonDecode("teams.json")
}
