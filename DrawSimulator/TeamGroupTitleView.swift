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
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    private var flagWidth: CGFloat { geoSizeTracker.getSize().width * 0.06 }
    private var flagHeight: CGFloat { flagWidth * 3/4 }
    private let whiteFlagFactor = 1.3
    
    var body: some View {
        
        switch userSettings.grouping {
            case .country:
                Label {
                    Text(SharedConstants.countries[team.countryId]!.name)
                } icon: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(.white)
                            .frame(width: flagWidth * whiteFlagFactor, height: flagHeight * whiteFlagFactor)
                        
                        Image(SharedConstants.countries[team.countryId]!.name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: flagWidth, height: flagHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    }
                }
                .labelStyle(.titleAndIcon)
                
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
