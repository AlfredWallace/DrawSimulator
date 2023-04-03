//
//  Configuration.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation

class Configuration: ObservableObject, Codable {
    
    private static let savePath = FileManager.documentsDirectory.appendingPathComponent("configuration.json")
    
    enum Grouping: String, Codable {
        case pool, country
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
            let decoded = try JSONDecoder().decode(Configuration.self, from: contents)
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
            print("Unable to save configuration: \(error.localizedDescription)")
        }
    }
}
