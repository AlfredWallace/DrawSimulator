//
//  OpponentView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 27/06/2023.
//

import SwiftUI

struct OpponentView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    @EnvironmentObject private var draws: Draws
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    let team: Team
    let seasonTeam: SeasonTeam
    let opponent: SeasonTeam
    
    init(seasonTeam: SeasonTeam, opponent: SeasonTeam) {
        self.seasonTeam = seasonTeam
        self.team = seasonTeam.team!
        self.opponent = opponent
    }
    
    private var drawPairings: [DrawPairing] {
        seasonTeam.season!.drawPairingsArray.filter {
            if seasonTeam.seeded {
                return $0.seededTeam == team
            } else {
                return $0.unseededTeam == team
            }
        }
    }
    
    private var totalPairingCount: Float {
        Float(
            drawPairings.reduce(0) { acc, drawPairing in
                acc + drawPairing.count
            }
        )
    }
    
    private var opponentPercentageString: String {
        var percentage: Float = 0.0
        let opponentTeam = opponent.team!
        
        let pairing = drawPairings.first(where: {
            if seasonTeam.seeded {
                return $0.unseededTeam == opponentTeam
            } else {
                return $0.seededTeam == opponentTeam
            }
        })
        
        if let pairing {
            percentage = Float(pairing.count) / totalPairingCount * 100
        }
        
        return "\(percentage.rounded().formatted())"
    }
    
    var body: some View {
        HStack {
            TeamLabelView(team: opponent.team!, textStyle: .title2)
                .padding(.trailing, 10)
            
            Spacer()
            
            HStack {
                Spacer()
                
                if draws.isRunning {
                    ProgressView(value: draws.progress, total: Double(userSettings.drawAccuracyCount))
                        .progressViewStyle(RandomNumberProgressStyle())
                } else {
                    Text(opponentPercentageString)
                }
                Text("%")
            }
            .frame(width: geoSizeTracker.getSize().width * 0.23)
            .font(.title3.bold().monospaced())
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(
                draws.isRunning
                ? "Waiting for the draw results"
                : "\(opponentPercentageString) %"
            )
        }
        .accessibilityElement(children: .combine)
    }
}

struct OpponentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let seasonTeam = PreviewDataFetcher.fetchData(
            for: SeasonTeam.self,
            withPredicate: NSPredicate(format: "team.shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )
        
        let opponent = PreviewDataFetcher.fetchData(
            for: SeasonTeam.self,
            withPredicate: NSPredicate(format: "team.shortName == %@", DatabaseInitializer.TeamIdentifier.RMA.rawValue)
        )
        
        List {
            Section {
                OpponentView(seasonTeam: seasonTeam, opponent: opponent)
                    .environmentObject(Draws(coreDataController: CoreDataController.preview))
                    .environmentObject(GeoSizeTracker())
                    .environmentObject(UserSettings())
            }
        }
    }
}
