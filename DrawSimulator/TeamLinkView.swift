//
//  TeamLinkView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamLinkView: View {
    
    let team: Team
    let countriesDict: [Int: Country]
    let geo: GeometryProxy
    
    var logoSize: CGFloat { geo.size.width * 0.12 }
    var flagSize: CGFloat { geo.size.width * 0.08 }
    
    @EnvironmentObject var configuration: Configuration
    
    var body: some View {
        
        HStack {
        
            Image(team.name)
                .resizable()
                .scaledToFit()
                .padding(4)
                .frame(maxWidth: logoSize, maxHeight: logoSize)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(team.name)
                .font(.title)
                .padding(.leading)
            
            Spacer()
            
            if configuration.grouping == .pool {
                Image(countriesDict[team.countryId]!.name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: flagSize * 4 / 3, height: flagSize)
                    .clipped()
                    .border(.white, width: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    .padding(.trailing)
                
            } else {
                HStack {
                    Image(systemName: "\(team.pool.lowercased()).circle")
                        .foregroundColor(
                            Color(red: 0.54, green: 0.69, blue: 0.8)
                        )
                    Image(systemName: "\(team.seeded ? "1" : "2").circle")
                        .foregroundColor(
                            team.seeded
                            ? Color(red: 0.0, green: 0.68, blue: 0.05)
                            : Color(red: 0.8, green: 0.4, blue: 0.1)
                        )
                }
                .font(.title3)
            }
        }
    }
}

struct TeamLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GeometryReader { geo in
                List(Team.examples, id: \.self) { team in
                    NavigationLink(value: team) {
                        TeamLinkView(team: team, countriesDict: Country.examples, geo: geo)
                    }
                    .listRowBackground(Color.accentColor)
                    .foregroundColor(.white)
                }
            }
        }
        .environmentObject(Configuration(forcedGrouping: .pool))
    }
}
