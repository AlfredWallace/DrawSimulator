//
//  FlagLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct FlagLabelView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    enum Size {
        case small, medium, large
    }
    
    private let team: Team
    private let flagWidthFactor: CGFloat
    private let borderFactor: CGFloat
    private let fontSize: Font
    
    init(team: Team, size: Size = .small) {
        self.team = team
        
        switch size {
            case .large:
                flagWidthFactor = 0.1
                borderFactor = 1.2
                fontSize = .largeTitle
            case .medium:
                flagWidthFactor = 0.08
                borderFactor = 1.25
                fontSize = .title
            default:
                flagWidthFactor = 0.06
                borderFactor = 1.3
                fontSize = .title2
        }
    }
    
    private var flagWidth: CGFloat { geoSizeTracker.getSize().width * flagWidthFactor }
    private var flagHeight: CGFloat { flagWidth * 3/4 }
    private var countryName: String {
        let country = SharedConstants.countries[team.countryId]!
        
        if dynamicTypeSize > .xxxLarge {
            return country.shortName
        }
        
        return country.name
    }
    
    var body: some View {
        Label {
            Text(countryName)
                .font(fontSize)
        } icon: {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(.white)
                    .frame(width: flagWidth * borderFactor, height: flagHeight * borderFactor)
                
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
            VStack {
                FlagLabelView(team: Team.examples.first!, size: .small)
                    .environmentObject(geoSizeTracker)
                FlagLabelView(team: Team.examples.first!, size: .medium)
                    .environmentObject(geoSizeTracker)
                FlagLabelView(team: Team.examples.first!, size: .large)
                    .environmentObject(geoSizeTracker)
            }
        }
        .padding(20)
        .background(Color.pitchGreen)
    }
}
