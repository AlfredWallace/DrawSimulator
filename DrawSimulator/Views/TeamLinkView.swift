//
//  TeamLinkView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamLinkView: View {
    
    let team: Team
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        
        NavigationLink(value: team) {
            
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        TeamLogoView(team: team, widthPercentage: 15)
                        
                        Text(team.name.uppercased())
                            .font(.custom(Fonts.Chillax.bold.rawValue, size: 26, relativeTo: .largeTitle))
                    }
                }
                .scrollIndicators(.hidden)
                
                Image(systemName: "chevron.forward")
            }
        }
    }
}
