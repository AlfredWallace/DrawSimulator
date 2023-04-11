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
    
    var flagSize: CGFloat { geo.size.width * 0.04 }
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
                    
                    HStack {
                        Label {
                            Text(SharedConstants.countries[team.countryId]!.shortName)
                        } icon: {
                            Image(SharedConstants.countries[team.countryId]!.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: flagSize * 4/3, height: flagSize)
                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                        }
                        .labelStyle(.titleAndIcon)
                        .tagStyled()
                        
                        Text(team.pool)
                            .tagStyled()
                        
                        if team.seeded {
                            Text("Seed")
                                .tagStyled()
                        }
                    }
                    .foregroundColor(.darkGray)
                }
                .fontWeight(.bold)
                .padding(.leading)
            }
        }
    }
}
