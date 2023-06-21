//
//  SettingsView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Dismiss me!") {
            dismiss()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
