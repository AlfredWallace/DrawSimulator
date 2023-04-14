//
//  TeamListLinkView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamListLinkView: View {
    
    let team: Team
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var geoSizeTracker: GeoSizeTracker
    
    var logoSize: CGFloat { geoSizeTracker.getSize().width * 0.15 }
    
    var body: some View {
        
        NavigationLink(value: team) {
            
            HStack(alignment: .center) {
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize, height: logoSize)
                
                Text(team.name.uppercased())
                    .font(.custom(SharedConstants.Chillax.bold.rawValue, size: 28, relativeTo: .largeTitle))
                
                Spacer()
                
                Image(systemName: "chevron.forward")
            }
        }
    }
}
