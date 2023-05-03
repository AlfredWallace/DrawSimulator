//
//  TeamLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 16/04/2023.
//

import SwiftUI

struct TeamLabelView: View {
    
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker

    let team: Team
    let logoWidthPercentage: Int
    let textStyle: Font.TextStyle

    private var logoSize: CGFloat {
        geoSizeTracker.getSize().width * CGFloat(logoWidthPercentage) / 100
    }

    @ViewBuilder private var viewToFit: some View {
        Image(team.name)
            .resizable()
            .scaledToFit()
            .frame(width: logoSize, height: logoSize)

        Text(team.name.uppercased())
            .sportFont(textStyle)
    }

    init(team: Team, logoWidthPercentage: Int = 14, textStyle: Font.TextStyle = .body) {
        self.team = team
        self.logoWidthPercentage = logoWidthPercentage
        self.textStyle = textStyle
    }
    
    var body: some View {
        ViewThatFits {
            HStack {
                viewToFit
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    viewToFit
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
