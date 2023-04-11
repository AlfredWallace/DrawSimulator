//
//  UserSettings.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation

class UserSettings: ObservableObject, Codable {
    
    private static let savePath = FileManager.documentsDirectory.appendingPathComponent("userSettings.json")
    
    enum Grouping: String, Codable {
        case pool, country, seeding, none
    }
    
    private(set) var grouping: Grouping
    
    func setGrouping(_ grouping: Grouping) {
        objectWillChange.send()
        self.grouping = grouping
        save()
    }
    
    init(forcedGrouping: Grouping) {
        grouping = forcedGrouping
    }
    
    init() {
        do {
            let contents = try Data(contentsOf: Self.savePath)
            let decoded = try JSONDecoder().decode(UserSettings.self, from: contents)
            grouping = decoded.grouping
        } catch {
            grouping = Grouping.pool
        }
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(self)
            try encoded.write(to: Self.savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save user settings: \(error.localizedDescription)")
        }
    }
}
