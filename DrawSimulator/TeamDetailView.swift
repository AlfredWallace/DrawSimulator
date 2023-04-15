//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    @EnvironmentObject private var geoSizeTracker: GeoSizeTracker
    
    private var logoSize: CGFloat { geoSizeTracker.getSize().width * 0.25 }
    
    let team: Team
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.pitchGreen.gradient)
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    Image(team.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: logoSize, height: logoSize)
                    
                    VStack {
                        FlagLabelView(team: team, size: .large)
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 15)
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

