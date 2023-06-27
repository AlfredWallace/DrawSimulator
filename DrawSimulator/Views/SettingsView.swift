//
//  SettingsView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var draws: Draws
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        NavigationStack {
            Form {
                Picker(selection: $userSettings.displayMode) {
                    ForEach(UserSettings.DisplayMode.allCases) {
                        Text($0.rawValue.capitalized)
                            .tag($0)
                    }
                } label: {
                    Text("Display mode")
                        .sectionTitle()
                }
                
                Picker(selection: $userSettings.drawAccuracy) {
                    ForEach(UserSettings.DrawAccuracy.allCases) {
                        Text(userSettings.getDrawAccuracyLabel(drawAccuracy: $0))
                            .tag($0)
                    }
                } label: {
                    Text("Draw speed/accuracy")
                        .sectionTitle()
                }
                .disabled(draws.isRunning)
            }
            .navigationTitle("Settings")
            .pickerStyle(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Draws(coreDataController: CoreDataController.preview))
            .environmentObject(UserSettings())
    }
}
