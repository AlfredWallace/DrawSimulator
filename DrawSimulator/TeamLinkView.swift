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
                .padding(6)
                .frame(width: logoSize, height: logoSize)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 17, style: .continuous))
            
            Text(team.name)
                .font(.title)
                .padding(.leading)
            
            Spacer()
            
            if configuration.grouping == .pool {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.white)
                        .frame(width: flagSize * 4 / 3 * 1.2, height: flagSize * 1.2)
                    
                    Image(countriesDict[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: flagSize * 4 / 3, height: flagSize)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                }
                .padding(.trailing)
                
            } else {
                HStack {
                    team.poolImage
                    team.seededImage
                }
                .font(.title3)
                .padding(4)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                
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
        .environmentObject(Configuration(forcedGrouping: .country))
    }
}
