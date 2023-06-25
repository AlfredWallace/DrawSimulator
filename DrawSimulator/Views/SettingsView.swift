//
//  SettingsView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var userSettings: UserSettings
    @EnvironmentObject private var draws: Draws
    
    private let accuracy = [
        1_000: "Fastest, least precise",
        2_000: "Balanced",
        5_000: "Slowest, most precise",
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker(selection: $userSettings.data.displayMode) {
                    ForEach(UserSettings.DisplayMode.allCases) {
                        Text($0.rawValue.capitalized)
                            .tag($0)
                    }
                } label: {
                    Text("Display mode")
                        .sectionTitle()
                }
                .pickerStyle(.inline)
                
                Picker(selection: $userSettings.data.numberOfDraws) {
                    ForEach(accuracy.keys.sorted(), id: \.self) {
                        Text(accuracy[$0, default: "error"])
                            .tag($0)
                    }
                } label: {
                    Text("Draw speed/accuracy")
                        .sectionTitle()
                }
                .pickerStyle(.inline)
                .disabled(draws.isRunning)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserSettings())
            .environmentObject(Draws(coreDataController: CoreDataController.preview))
    }
}
