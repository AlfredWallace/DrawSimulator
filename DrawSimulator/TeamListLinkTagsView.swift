//
//  TeamListLinkTagsView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 11/04/2023.
//

import SwiftUI

struct TeamListLinkTagsView: View {
    let team: Team
    let geo: GeometryProxy
    
    var flagSize: CGFloat { geo.size.width * 0.04 }
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        HStack {
            
            if userSettings.grouping != .country {
                Label {
                    Text(SharedConstants.countries[team.countryId]!.shortName)
                } icon: {
                    Image(SharedConstants.countries[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: flagSize * 4/3, height: flagSize)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                }
                .labelStyle(.titleAndIcon)
                .tagStyled()
            }
            
            if userSettings.grouping != .pool {
                Text(team.pool)
                    .tagStyled()
            }
            
            if team.seeded && userSettings.grouping != .seeding {
                Text("Seed")
                    .tagStyled()
            }
        }
        .foregroundColor(.darkGray)
    }
}
