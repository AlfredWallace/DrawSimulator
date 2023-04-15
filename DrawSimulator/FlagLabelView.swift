//
//  FlagLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct FlagLabelView: View {
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    private var flagWidth: CGFloat { geoSizeTracker.getSize().width * 0.06 }
    private var flagHeight: CGFloat { flagWidth * 3/4 }
    private let whiteFlagFactor = 1.3
    
    let team: Team
    
    var body: some View {
        Label {
            Text(SharedConstants.countries[team.countryId]!.name)
        } icon: {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(.white)
                    .frame(width: flagWidth * whiteFlagFactor, height: flagHeight * whiteFlagFactor)
                
                Image(SharedConstants.countries[team.countryId]!.name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: flagWidth, height: flagHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            }
        }
        .labelStyle(.titleAndIcon)
    }
}

struct FlagLabelView_Previews: PreviewProvider {
    static let geoSizeTracker = GeoSizeTracker()
    
    static var previews: some View {
        GeometryReader { geo in
            FlagLabelView(team: Team.examples.first!)
                .environmentObject(geoSizeTracker)
        }
        .padding(20)
        .background(Color.pitchGreen)
    }
}
