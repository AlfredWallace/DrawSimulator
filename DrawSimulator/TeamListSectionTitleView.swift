//
//  TeamListSectionTitleView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 04/04/2023.
//

import SwiftUI

struct TeamListSectionTitleView: View {
    let team: Team
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        Group {
            switch userSettings.grouping {
                case .country:
                    Text(SharedConstants.countries[team.countryId]!.name)
                case .pool:
                    Text("Pool \(team.pool)")
                case .seeding:
                    Text(team.seeded ? "Seeded teams" : "Unseeded teams")
                default:
                    Text("Alphabetical order")
                    
            }
        }
        .font(.title2.bold())
    }
}
