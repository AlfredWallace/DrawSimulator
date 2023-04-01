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
    var flagSize: CGFloat { geo.size.width * 0.07 }
    
    @EnvironmentObject var configuration: Configuration
    
    var body: some View {
            
            HStack {
                
                Image(team.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize, height: logoSize)
                
                Text(team.name)
                    .font(.title)
                    .padding(.leading)
                
                Spacer()
                
                if configuration.grouping == .pool {
                    Image(countriesDict[team.countryId]!.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: flagSize, height: flagSize)
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
        
//        GeometryReader { geo in
//            HStack {
//                let logoSize = geo.size.width * 0.12
//                let flagSize = geo.size.width * 0.07
//
//                Image(team.name)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: logoSize, height: logoSize)
//                    .padding(.vertical)
//
//                Text(team.name)
//                    .font(.title)
//                    .padding(.leading)
//
//                Spacer()
//
//                if configuration.grouping == .pool {
//                    Image(countriesDict[team.countryId]!.name)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: flagSize, height: flagSize)
//                        .padding(.trailing)
//                } else {
//                    HStack {
//                        Image(systemName: "\(team.pool.lowercased()).circle")
//                            .foregroundColor(
//                                Color(red: 0.54, green: 0.69, blue: 0.8)
//                            )
//                        Image(systemName: "\(team.seeded ? "1" : "2").circle")
//                            .foregroundColor(
//                                team.seeded
//                                ? Color(red: 0.0, green: 0.68, blue: 0.05)
//                                : Color(red: 0.8, green: 0.4, blue: 0.1)
//                            )
//                    }
//                    .font(.title3)
//                }
//            }
//        }
    }
}

struct TeamLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GeometryReader { geo in
                List {
                    NavigationLink(value: Team.example) {
                        TeamLinkView(team: Team.example, countriesDict: [1: Country.example], geo: geo)
                            .environmentObject(Configuration())
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}
