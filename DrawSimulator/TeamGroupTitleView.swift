//
//  TeamGroupTitleView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 04/04/2023.
//

import SwiftUI

struct TeamGroupTitleView: View {
    
    let team: Team
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        
        switch userSettings.grouping {
            case .country:
                FlagLabelView(team: team)
                
            case .pool:
                HStack {
                    Text("Pool")
                    Image(systemName: "\(team.pool.lowercased()).circle.fill")
                }
                
            case .seeding:
                if team.seeded {
                    Label {
                        Text("Seeded teams")
                    } icon: {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.pitchGreen)
                    }
                } else {
                    Text("Unseeded teams")
                }
                
            default:
                Text("Alphabetical order")
                
        }
    }
}
