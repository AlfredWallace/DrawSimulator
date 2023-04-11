//
//  TeamListLinkInfoBadgeView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 08/04/2023.
//

import SwiftUI

struct TeamListLinkInfoBadgeView: View {
    
    let team: Team
    let geo: GeometryProxy
    let size: CGFloat
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ZStack {
            
            // The central element is:
            // - the pool when the grouping is "country"
            // - the flag in all other cases
            if userSettings.grouping == .country {
                Image(systemName: "\(team.pool.lowercased()).square")
                    .foregroundColor(.darkGray)
                    .font(.largeTitle)
            } else {
                
                Image(SharedConstants.countries[team.countryId]!.name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size * 0.5 * 4/3, height: size * 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            
            // Layout to display 2 badges at top right and bottom left corner
            
            VStack {
                // This HStack is pushed to the top
                HStack {
                    Spacer()
                    // The top right badge is shown when the grouping is seeding or none
                    if userSettings.grouping == .seeding || userSettings.grouping == .none {
                        Image(systemName: "\(team.pool.lowercased()).circle.fill")
                            .foregroundColor(.darkGray)
                            .font(.callout)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                // This HStack is pushed to the bottom
                HStack {
                    // The bottom left badge is displayed:
                    // - if the team is seeded
                    // - and if we're not grouping by seeding
                    if team.seeded && userSettings.grouping != .seeding {
                        Image(systemName: "s.circle.fill")
                            .foregroundColor(.darkGray)
                            .font(.body)
                            .background(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
            }
            .padding(2)
        }
        .frame(width: size, height: size)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
