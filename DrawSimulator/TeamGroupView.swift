//
//  TeamGroupView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct TeamGroupView: View {
    let teams: [Team]
    
    var body: some View {
        VStack(spacing: 10) {
            TeamGroupTitleView(team: teams.first!)
                .bold()
                .padding(.horizontal, 15)
            
            DividerView()
            
            ForEach(teams) { team in
                TeamLinkView(team: team)
                    .padding(.horizontal, 15)
            }
        }
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.shadow(.drop(radius: 5, y: 5)))
                .foregroundStyle(Color.defaultBackground)
        )
    }
}
