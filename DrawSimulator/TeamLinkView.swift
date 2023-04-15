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
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    private var logoSize: CGFloat { geoSizeTracker.getSize().width * 0.15 }
    
    private var teamName: String {
        if dynamicTypeSize >= .xxxLarge {
            return team.shortName
        }
        
        return team.name
    }
    
    var body: some View {
        
        NavigationLink(value: team) {
            
            HStack(alignment: .center) {
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize, height: logoSize)
                
                Text(teamName.uppercased())
                    .font(.custom(SharedConstants.Chillax.bold.rawValue, size: 28, relativeTo: .largeTitle))
                
                Spacer()
                
                Image(systemName: "chevron.forward")
            }
        }
    }
}
