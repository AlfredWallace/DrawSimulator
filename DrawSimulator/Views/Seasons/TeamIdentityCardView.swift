//
//  TeamIdentityCardView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 10/07/2023.
//

import SwiftUI

struct TeamIdentityCardView: View {

    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    let seasonTeam: SeasonTeam
    let team: Team

    init(seasonTeam: SeasonTeam) {
        self.seasonTeam = seasonTeam
        self.team = seasonTeam.team!
    }

    private var logoSize: CGFloat {
        var factor = 1.0

        switch dynamicTypeSize {
            case .xSmall:
                factor = 0.36
            case .small:
                factor = 0.38
            case .medium:
                factor = 0.40
            case .large:
                factor = 0.42
            case .xLarge:
                factor = 0.44
            case .xxLarge:
                factor = 0.46
            default:
                factor = 0.75
        }

        return geoSizeTracker.getSize().width * factor
    }

    var body: some View {
        Section {
            StackThatFits {

                Image(team.shortName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize, height: logoSize)
                    .accessibilityHidden(true)

                VStack {
                    HStack {
                        Text("Pool")
                        Image(systemName: "\(seasonTeam.poolName.lowercased()).circle.fill")
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Pool \(seasonTeam.poolName)")

                    DividerView()

                    FlagLabelView(team: team)

                    DividerView()

                    Text(seasonTeam.seededString)
                }
            }
            .font(.title2.bold())
        }
        .listSectionSeparator(.hidden)
    }
}

struct TeamIdentityCardView_Previews: PreviewProvider {

    static var geoSizeTracker = GeoSizeTracker()

    static var previews: some View {

        let seasonTeam = PreviewDataFetcher.fetchData(
            for: SeasonTeam.self,
            withPredicate: NSPredicate(format: "team.shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )

        return ZStack {

            GeometryReader { geoWrapper in
                Spacer()
                    .onAppear {
                        geoSizeTracker.setSize(geoWrapper.size)
                    }
            }

            TeamIdentityCardView(seasonTeam: seasonTeam)
                .environmentObject(geoSizeTracker)
        }
    }
}
