//
//  TeamLogoView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 16/04/2023.
//

import SwiftUI

struct TeamLogoView: View {
    
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    let team: Team
    let widthPercentage: Int
    
    var logoSize: CGFloat {
        geoSizeTracker.getSize().width * CGFloat(widthPercentage) / 100
    }
    
    var body: some View {
        Image(team.name)
            .resizable()
            .scaledToFit()
            .frame(width: logoSize, height: logoSize)
    }
}
