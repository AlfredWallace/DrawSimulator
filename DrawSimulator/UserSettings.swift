//
//  UserSettings.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation
import SwiftUI


struct UserSettings {
    
    enum Grouping: String, Codable, CaseIterable, Identifiable {
        case pool, country, seeding, none
        var id: Self { self }
    }
    
    enum DisplayMode: String, Codable, CaseIterable, Identifiable {
        case light, dark, system
        var id: Self { self }
    }
    
    enum DrawAccuracy: String, CaseIterable, Identifiable {
        case low, medium, high
        var id: Self { self }
    }
    
    static let drawAccuracyCount: [DrawAccuracy: Int] = [
        .low: 1_000,
        .medium: 2_000,
        .high: 5_000,
    ]
    
    static let drawAccuracyLabel: [DrawAccuracy: String] = [
        .low: "Fastest, least precise",
        .medium: "Balanced",
        .high: "Slowest, most precise",
    ]
    
    static func getColorScheme(_ displayMode: DisplayMode) -> ColorScheme? {
        
        if displayMode == .light { return .light }
        
        if displayMode == .dark { return .dark }
        
        return nil
    }
}
