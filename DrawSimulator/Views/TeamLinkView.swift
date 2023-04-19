//
//  TeamLinkView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamLinkView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let team: Team
    
    @EnvironmentObject private var userSettings: UserSettings
    
    private var teamName: String {
        if dynamicTypeSize > .xxxLarge {
            return team.shortName
        }
        
        return team.name
    }
    
    var body: some View {
        
        NavigationLink(value: team) {
            
            HStack(alignment: .center) {
                TeamLogoView(team: team, widthPercentage: 15)
                
                Text(teamName.uppercased())
                    .font(.custom(Fonts.Chillax.bold.rawValue, size: 26, relativeTo: .largeTitle))
                
                Spacer()
                
                Image(systemName: "chevron.forward")
            }
        }
    }
}
