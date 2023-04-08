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
    let flagBorderMultiplier = 1.13
    var flagHeight: CGFloat { geo.size.width * 0.08 }
    var flagWidth: CGFloat { flagHeight * 4 / 3 }
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        switch userSettings.grouping {
            case .pool:
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .frame(width: flagWidth * flagBorderMultiplier, height: flagHeight * flagBorderMultiplier)
                    
                    Image(SharedConstants.countries[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: flagWidth, height: flagHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
            default:
                HStack {
                    if team.seeded {
                        Image(systemName: team.seededImageName)
                    }
                    
                    Image(systemName: team.poolImageName)
                }
                .foregroundColor(.darkGray)
                .font(.title3)
                .padding(1)
                .background(.white)
                .clipShape(Capsule())
        }
    }
}
