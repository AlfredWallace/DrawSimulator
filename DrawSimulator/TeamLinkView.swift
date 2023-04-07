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
    let flagBorderMultiplier = 1.13
    var logoSize: CGFloat { geo.size.width * 0.12 }
    var flagHeight: CGFloat { geo.size.width * 0.08 }
    var flagWidth: CGFloat { flagHeight * 4 / 3 }
    
    @EnvironmentObject var userSettings: UserSettings
    
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
            
            if userSettings.grouping == .pool {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .frame(width: flagWidth * flagBorderMultiplier, height: flagHeight * flagBorderMultiplier)
                    
                    Image(countriesDict[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: flagWidth, height: flagHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .padding(.trailing)
                
            } else {
                HStack {
                    team.poolImage
                    team.seededImage
                }
                .font(.title3)
                .padding(1)
                .background(.white)
                .clipShape(Capsule())
                
            }
        }
    }
}

//struct TeamLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            GeometryReader { geo in
//                List(Team.examples, id: \.self) { team in
//                    NavigationLink(value: team) {
//                        TeamLinkView(team: team, countriesDict: Country.examples, geo: geo)
//                    }
//                    .listRowBackground(Color.accentColor)
//                    .foregroundColor(.white)
//                }
//            }
//        }
//        .environmentObject(UserSettings(forcedGrouping: .country))
//    }
//}
