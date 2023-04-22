//
//  TeamLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 16/04/2023.
//

import SwiftUI

struct TeamLabelView: View {
    
//    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
//
//    let team: Team
//    let logoWidthPercentage: Int
//    let fontSize: Int
//
//    private var logoSize: CGFloat {
//        geoSizeTracker.getSize().width * CGFloat(logoWidthPercentage) / 100
//    }
//
//    @ViewBuilder private var viewToFit: some View {
//        Image(team.name)
//            .resizable()
//            .scaledToFit()
//            .frame(width: logoSize, height: logoSize)
//
//        Text(team.name.uppercased())
//            .font(.custom(Fonts.Chillax.bold.rawValue, size: CGFloat(fontSize), relativeTo: .largeTitle))
//    }
//
//    init(team: Team, logoWidthPercentage: Int = 14, fontSize: Int = 26) {
//        self.team = team
//        self.logoWidthPercentage = logoWidthPercentage
//        self.fontSize = fontSize
//    }
    
    var body: some View {
        Text("TeamLabelView")
//        ViewThatFits {
//            HStack {
//                viewToFit
//                Spacer()
//            }
//            
//            ScrollView(.horizontal) {
//                HStack {
//                    viewToFit
//                }
//            }
//            .scrollIndicators(.hidden)
//        }
    }
}
