//
//  TeamNameThatFits.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 21/06/2023.
//

import SwiftUI

struct TeamNameThatFits: View {
    let team: Team
    let textStyle: Font.TextStyle
    
    init(team: Team, textStyle: Font.TextStyle = .body) {
        self.team = team
        self.textStyle = textStyle
    }
    
    var body: some View {
        ViewThatFits {
            Text(team.name.uppercased())
            Text(team.shortName.uppercased())
        }
        .sportFont(textStyle)
    }
}

struct TeamNameThatFits_Previews: PreviewProvider {
    static var previews: some View {
        let team = PreviewDataFetcher.fetchData(
            for: Team.self,
            withPredicate: NSPredicate(format: "shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )
        TeamNameThatFits(team: team)
    }
}
