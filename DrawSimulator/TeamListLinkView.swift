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
    
    var body: some View {
        
        NavigationLink(value: team) {
            HStack(alignment: .center) {
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(team.name.uppercased())
                        .font(.custom(SharedConstants.Chillax.bold.rawValue, size: 26, relativeTo: .largeTitle))
                    
//                    TeamListLinkTagsView(team: team, geo: geo) todo : rework entirely
                }
                .fontWeight(.bold)
                .padding(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.forward")
            }
        }
    }
}
