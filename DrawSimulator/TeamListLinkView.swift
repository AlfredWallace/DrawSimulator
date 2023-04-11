//
//  TeamListLinkView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamListLinkView: View {
    
    let team: Team
    let geo: GeometryProxy
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        NavigationLink(value: team) {
            HStack {
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .padding(6)
                    .teamListLinkInfoBackgroundViewModifier(geo)
                
                Text(team.name)
                    .font(.largeTitle)
                    .padding(.leading)
                
                Spacer()
                
                TeamListLinkInfoBadgeView(team: team, geo: geo)
            }
        }
    }
}
