//
//  UserSettings.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation
import SwiftUI


@MainActor class UserSettings: ObservableObject {
    
    private static let savePath = FileManager.documentsDirectory.appendingPathComponent("userSettings.json")
    
    enum Grouping: String, Codable {
        case pool, country, seeding, none
    }
    
    enum DisplayMode: String, Codable {
        case light, dark, system
    }
    
    struct SettingsToSave: Codable {
        var grouping: Grouping
        var displayMode: DisplayMode
    }
    
    @Published private(set) var data: SettingsToSave
    
    func setGrouping(_ grouping: Grouping) {
        data.grouping = grouping
        save()
    }
    
    func setDisplayMode(_ displayMode: DisplayMode) {
        data.displayMode = displayMode
        save()
    }
    
    func getDisplayModeIconName(for displayMode: DisplayMode? = nil) -> String {
        
        // If no argument is provided, we call the same function with the user defined value
        if displayMode == nil { return getDisplayModeIconName(for: data.displayMode) }
        
        if displayMode == .light { return "sun.max" }
        
        if displayMode == .dark { return "moon.stars" }
        
        return "circle.righthalf.filled"
    }
    
    func getColorScheme() -> ColorScheme? {
        
        if data.displayMode == .light { return .light }
        
        if data.displayMode == .dark { return .dark }
        
        return nil
    }
    
    init() {
        do {
            let contents = try Data(contentsOf: Self.savePath)
            let decoded = try JSONDecoder().decode(SettingsToSave.self, from: contents)
            data = SettingsToSave(grouping: decoded.grouping, displayMode: decoded.displayMode)
        } catch {
            data = SettingsToSave(grouping: Grouping.pool, displayMode: DisplayMode.system)
        }
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(data)
            try encoded.write(to: Self.savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save user settings: \(error.localizedDescription)")
        }
    }
}
