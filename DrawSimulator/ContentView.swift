//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userSettings = UserSettings()
    
    var body: some View {
        NavigationStack {
            TeamListView().background(Color.pitchGreen.gradient)
                .foregroundColor(.defaultText)
        }
        .environmentObject(userSettings)
        .preferredColorScheme(userSettings.getColorScheme())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
