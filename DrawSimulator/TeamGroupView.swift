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
        VStack(alignment: .leading, spacing: 10) {
            TeamListSectionTitleView(team: teams.first!)
                .font(.title2.bold())
                .padding(.horizontal, 15)
            
            Rectangle()
                .fill(Color.pitchGreen)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
            
            ForEach(teams) { team in
                TeamListLinkView(team: team)
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
