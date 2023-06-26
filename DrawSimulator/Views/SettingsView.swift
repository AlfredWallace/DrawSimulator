//
//  SettingsView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("displayMode") private var displayMode = UserSettings.DisplayMode.system
    @AppStorage("drawAccuracy") private var drawAccuracy = UserSettings.DrawAccuracy.medium
    
    @EnvironmentObject private var draws: Draws
    
    var body: some View {
        NavigationStack {
            Form {
                Picker(selection: $displayMode) {
                    ForEach(UserSettings.DisplayMode.allCases) {
                        Text($0.rawValue.capitalized)
                            .tag($0)
                    }
                } label: {
                    Text("Display mode")
                        .sectionTitle()
                }
                .pickerStyle(.inline)
                
                Picker(selection: $drawAccuracy) {
                    ForEach(UserSettings.DrawAccuracy.allCases) {
                        Text(UserSettings.drawAccuracyLabel[$0, default: "error"])
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
            .environmentObject(Draws(coreDataController: CoreDataController.preview))
    }
}
