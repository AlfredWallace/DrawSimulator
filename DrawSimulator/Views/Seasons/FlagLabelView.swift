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

    let country: Country
    
    init(team: Team) {
        country = team.country!
    }

    private var flagWidth: CGFloat {
        var factor = 1.0
        
        switch dynamicTypeSize {
            case .xSmall:
                fallthrough
            case .small:
                factor = 0.06
            case .medium:
                fallthrough
            case .large:
                factor = 0.07
            case .xLarge:
                fallthrough
            case .xxLarge:
                factor = 0.08
            case .xxxLarge:
                fallthrough
            case .accessibility1:
                factor = 0.09
            default:
                factor = 0.1
        }
        
        return geoSizeTracker.getSize().width * factor
    }
    
    private var flagHeight: CGFloat {
        flagWidth * 3/4
    }
    
    private let borderFactor = 1.1
    
    var body: some View {
        Label {
            ViewThatFits {
                Text(country.name)
                Text(country.shortName)
            }
        } icon: {
            ZStack {
                
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(Color.lightGray)
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

struct FlagLabelView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        let seasonTeam = PreviewDataFetcher.fetchData(
            for: SeasonTeam.self,
            withPredicate: NSPredicate(format: "team.shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )
        
        FlagLabelView(team: seasonTeam.team!)
            .environmentObject(GeoSizeTracker())
    }
}
