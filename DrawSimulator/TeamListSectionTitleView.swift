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
            if userSettings.grouping == .pool {
                HStack {
                    Text("Pool")
                        .foregroundColor(.lightGray)
                        .font(.title2)
                    
                    Image(systemName: team.poolImageName)
                        .foregroundColor(.darkGray)
                        .background(.white)
                        .clipShape(Circle())
                        .font(.title3)
                }
            } else {
                Text(SharedConstants.countries[team.countryId]!.name)
                    .font(.title2)
            }
        }
    }
}
