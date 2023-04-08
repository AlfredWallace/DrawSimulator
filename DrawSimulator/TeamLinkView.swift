//
//  TeamLinkView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamLinkView: View {
    
    let team: Team
    let geo: GeometryProxy
    var logoSize: CGFloat { geo.size.width * 0.12 }
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        NavigationLink(value: team) {
            HStack {
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .padding(6)
                    .frame(width: logoSize, height: logoSize)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 17, style: .continuous))
                
                Text(team.name)
                    .font(.title)
                    .padding(.leading)
                
                Spacer()
                
                TeamInfoBadgeView(team: team, geo: geo)
            }
        }
    }
}
