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
    
    init(team: Team, logoWidthPercentage: Int = 14, textStyle: Font.TextStyle = .body) {
        self.team = team
        self.logoWidthPercentage = logoWidthPercentage
        self.textStyle = textStyle
    }
    
    var body: some View {
        HStack {
            Image(team.shortName)
                .resizable()
                .scaledToFit()
                .frame(width: logoSize, height: logoSize)
            
            Text(team.name.uppercased())
                .sportFont(textStyle)
        }
    }
}

struct TeamLabelView_Previews: PreviewProvider {
    
    static var userSettings = UserSettings()
    static var geoSizeTracker = GeoSizeTracker()
    
    static var previews: some View {
        
        let moc = CoreDataController.preview.mainContext
        let team = PreviewDataFetcher.fetchData(
            for: Team.self,
            withPredicate: NSPredicate(format: "shortName == %@", DatabaseInitializer.TeamIdentifier.PSG.rawValue)
        )
        
        return ZStack {
            GeometryReader { geoWrapper in
                Spacer()
                    .onAppear {
                        geoSizeTracker.setSize(geoWrapper.size)
                    }
            }
            
            NavigationStack {
                List {
                    NavigationLink(value: team) {
                        TeamLabelView(team: team)
                    }
                }
                .listStyle(.plain)
            }
            
        }
        .environmentObject(geoSizeTracker)
        .tint(.defaultText)
    }
}
