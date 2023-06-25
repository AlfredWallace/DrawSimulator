//
//  FlagLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct FlagLabelView: View {
    
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker

    let country: Country
    
    init(team: Team) {
        country = team.country!
    }

    private var flagWidth: CGFloat { geoSizeTracker.getSize().width * 0.06 }
    private var flagHeight: CGFloat { flagWidth * 3/4 }
    private let borderFactor = 1.3
    
    var body: some View {
        Label {
            ViewThatFits {
                Text(country.name)
                Text(country.shortName)
            }
        } icon: {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(.white)
                    .frame(width: flagWidth * borderFactor, height: flagHeight * borderFactor)

                Image(country.name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: flagWidth, height: flagHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            }
        }
        .labelStyle(.titleAndIcon)
    }
}
