//
//  UserSettings.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation
import UIKit.UITraitCollection
import SwiftUI

class UserSettings: ObservableObject, Codable {
    
    private static let savePath = FileManager.documentsDirectory.appendingPathComponent("userSettings.json")
    
    enum Grouping: String, Codable {
        case pool, country, seeding, none
    }
    
    enum DisplayMode: String, Codable {
        case light, dark, system
    }
    
    private(set) var grouping: Grouping
    private(set) var displayMode: DisplayMode
    
    func setGrouping(_ grouping: Grouping) {
        objectWillChange.send()
        self.grouping = grouping
        save()
    }
    
    func setDisplayMode(_ displayMode: DisplayMode) {
        objectWillChange.send()
        self.displayMode = displayMode
        save()
    }
    
    func getDisplayModeIconName(for displayMode: DisplayMode? = nil) -> String {
        
        // If no argument is provided, we call the same function with the user defined value
        if displayMode == nil { return getDisplayModeIconName(for: self.displayMode) }
        
        if displayMode == .light { return "sun.max" }
        
        if displayMode == .dark { return "moon.stars" }
        
        return "iphone"
    }
    
    func getColorScheme() -> ColorScheme {
        if displayMode == .light { return .light }
        
        if displayMode == .dark { return .dark }
        
        let userInterfaceStyle = UITraitCollection.current.userInterfaceStyle
        
        if userInterfaceStyle == .dark { return .dark }
        
        return .light
    }
    
    init() {
        do {
            let contents = try Data(contentsOf: Self.savePath)
            let decoded = try JSONDecoder().decode(UserSettings.self, from: contents)
            grouping = decoded.grouping
            displayMode = decoded.displayMode
        } catch {
            grouping = Grouping.pool
            displayMode = DisplayMode.system
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
