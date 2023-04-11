//
//  TeamListLinkInfoBadgeView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 08/04/2023.
//

import SwiftUI

struct TeamListLinkInfoBadgeView: View {
    
    let team: Team
    let geo: GeometryProxy
    let flagBorderMultiplier = 1.13
    var flagHeight: CGFloat { geo.size.width * 0.08 }
    var flagWidth: CGFloat { flagHeight * 4 / 3 }
    var logoSize: CGFloat { geo.size.width * 0.12 }
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        ZStack {

            switch userSettings.grouping {
                case .country:
                    Image(systemName: "\(team.pool.lowercased()).square")
                        .foregroundColor(.darkGray)
                        .font(.largeTitle)
                    
                    if team.seeded {
                        VStack {
                            Spacer()
                            HStack {
                                Image(systemName: "s.circle.fill")
                                    .foregroundColor(.darkGray)
                                    .font(.body)
                                    .background(.white)
                                    .clipShape(Circle())
                                Spacer()
                            }
                        }
                        .padding(2)
                    }
                    
                case .pool:
                    Image(SharedConstants.countries[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: logoSize * 0.5 * 4/3, height: logoSize * 0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                case .seeding:
                    Image(SharedConstants.countries[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: logoSize * 0.5 * 4/3, height: logoSize * 0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "\(team.pool.lowercased()).circle.fill")
                                .foregroundColor(.darkGray)
                                .font(.callout)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(2)
                    
                default:
                    Image(SharedConstants.countries[team.countryId]!.name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: logoSize * 0.5 * 4/3, height: logoSize * 0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "\(team.pool.lowercased()).circle.fill")
                                .foregroundColor(.darkGray)
                                .font(.callout)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        HStack {
                            if team.seeded {
                                Image(systemName: "s.circle.fill")
                                    .foregroundColor(.darkGray)
                                    .font(.callout)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(2)
            }
        }
        .frame(width: logoSize, height: logoSize)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
