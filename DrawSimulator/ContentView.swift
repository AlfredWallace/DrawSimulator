//
//  ContentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 03/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var userSettings = UserSettings()
    @StateObject private var geoSizeTracker = GeoSizeTracker()
    
    var body: some View {
        GeometryReader { geoWrapper in
            NavigationStack {
                TeamListView()
                    .background(Color.pitchGreen.gradient)
                    .foregroundColor(.defaultText)
            }
            .environmentObject(userSettings)
            .environmentObject(geoSizeTracker)
            .preferredColorScheme(userSettings.getColorScheme())
            .onAppear {
                geoSizeTracker.setSize(geoWrapper.size)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
