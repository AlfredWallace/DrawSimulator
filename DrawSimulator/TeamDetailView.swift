//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    private var logoSize: CGFloat { geoSizeTracker.getSize().width * 0.45 }
    
    let team: Team
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Image(team.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: logoSize, height: logoSize)
                        
                        VStack(alignment: .center) {
                            PoolLabelView(team: team)
                            
                            DividerView()
                            
                            FlagLabelView(team: team)
                            
                            DividerView()
                            
                            if dynamicTypeSize <= .xxxLarge {
                                Text(team.seeded ? "Seeded" : "Unseeded")
                            } else {
                                Text(team.seeded ? "1st" : "2nd")
                            }
                        }
                        .font(.title2)
                        
                        Spacer()
                    }
                    .padding(10)
                    .carded()
                }
                .padding(.horizontal, 15)
            }
        }
        .navigationTitle(team.name)
    }
}


struct TeamDetailView_Previews: PreviewProvider {
    static let geoSizeTracker = GeoSizeTracker()
    
    static var previews: some View {
        GeometryReader { geo in
            NavigationStack {
                TeamDetailView(team: Team.examples.first!)
            }
            .onAppear {
                geoSizeTracker.setSize(geo.size)
            }
            .environmentObject(geoSizeTracker)
        }
    }
}

