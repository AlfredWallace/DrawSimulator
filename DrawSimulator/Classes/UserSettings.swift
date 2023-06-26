//
//  UserSettings.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation
import SwiftUI

@MainActor class UserSettings: ObservableObject {
    
    private let store = UserDefaults.standard
    
    enum Grouping: String, IterableEnum {
        case pool, country, seeding, none
    }
    
    enum DisplayMode: String, IterableEnum {
        case light, dark, system
    }
    
    enum DrawAccuracy: String, IterableEnum {
        case low, medium, high
    }
    
    let drawAccuracyCount: [DrawAccuracy: Int] = [
        .low: 1_000,
        .medium: 2_000,
        .high: 5_000,
    ]
    
    let drawAccuracyLabel: [DrawAccuracy: String] = [
        .low: "Fastest, least precise",
        .medium: "Balanced",
        .high: "Slowest, most precise",
    ]
    
    var displayMode: DisplayMode {
        get { self.get("displayMode", defaultValue: .system) }
        
        set { self.set("displayMode", newValue: newValue) }
    }
    
    var grouping: Grouping {
        get { self.get("grouping", defaultValue: .pool) }
        
        set { self.set("grouping", newValue: newValue) }
    }
    
    var drawAccuracy: DrawAccuracy {
        get { self.get("drawAccuracy", defaultValue: .medium) }
        
        set { self.set("drawAccuracy", newValue: newValue) }
    }
    
    private func get<T: RawRepresentable<String>>(_ key: String, defaultValue: T) -> T {
        guard let savedValue = store.string(forKey: key) else {
            return defaultValue
        }
        
        guard let result = T(rawValue: savedValue) else {
            return defaultValue
        }
        
        return result
    }
    
    private func set<T: RawRepresentable>(_ key: String, newValue: T) {
        objectWillChange.send()
        self.store.set(newValue.rawValue, forKey: key)
    }
    
    func getColorScheme() -> ColorScheme? {
        
        if displayMode == .light { return .light }
        
        if displayMode == .dark { return .dark }
        
        return nil
    }
    
}
