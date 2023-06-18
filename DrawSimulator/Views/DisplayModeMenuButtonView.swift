//
//  DisplayModeMenuButtonView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 14/04/2023.
//

import SwiftUI

struct DisplayModeMenuButtonView: View {
    @EnvironmentObject private var userSettings: UserSettings

    let displayMode: UserSettings.DisplayMode

    var label: String {
        switch displayMode {
            case .light:
                return "Light mode"
            case .dark:
                return "Dark mode"
            default:
                return "System"
        }
    }
    
    var body: some View {
        Button {
            userSettings.setDisplayMode(displayMode)
        } label: {
            Label(label, systemImage: userSettings.getDisplayModeIconName(for: displayMode))
        }
    }
}
