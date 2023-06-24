//
//  SettingsView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var userSettings: UserSettings
    
    private let accuracy = [
        1_000: "Fastest, least precise",
        2_000: "Balanced",
        5_000: "Slowest, most precise",
    ]
    
    var body: some View {
            Form {
                Picker("Display mode", selection: $userSettings.data.displayMode) {
                    ForEach(UserSettings.DisplayMode.allCases) {
                        Text($0.rawValue.capitalized)
                            .tag($0)
                    }
                }
                .pickerStyle(.inline)
                
                Picker("Draw speed/accuracy", selection: $userSettings.data.numberOfDraws) {
                    ForEach(accuracy.keys.sorted(), id: \.self) {
                        Text(accuracy[$0, default: "error"])
                            .tag($0)
                    }
                }
                .pickerStyle(.inline)
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserSettings())
    }
}
