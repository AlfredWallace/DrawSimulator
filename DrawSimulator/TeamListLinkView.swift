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
    var logoSize: CGFloat { geo.size.width * 0.16 }
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        NavigationLink(value: team) {
            HStack(alignment: .bottom) {
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .frame(width: logoSize, height: logoSize)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(team.name)
                        .font(.largeTitle)
                    
                    TeamListLinkTagsView(team: team, geo: geo)
                }
                .fontWeight(.bold)
                .padding(.leading)
            }
        }
    }
}
