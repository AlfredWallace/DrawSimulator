//
//  SeasonListView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/06/2023.
//

import SwiftUI

struct SeasonListView: View {
    
    @EnvironmentObject private var draws: Draws
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.winYear, order: .reverse)]) private var seasons: FetchedResults<Season>
    
    var body: some View {
        
        NavigationStack {
            
            List(seasons) { season in
                NavigationLink(value: season) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text(String(season.winYear))
                            .sportFont(.largeTitle, multiplier: 2.5)
                            .dynamicTypeSize(.xSmall ... .large)
                        
                        Group {
                            Text(season.stadium)
                            Text(season.city)
                        }
                        .sportFont(.body)
                    }
                }
                .listRowSeparatorTint(.pitchGreen)
            }
            .navigationTitle("Seasons")
            .navigationDestination(for: Season.self) { season in
                SeasonDetailView(season: season)
            }
        }
    }
}

struct SeasonListView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonListView()
            .environmentObject(Draws(coreDataController: CoreDataController.preview))
            .environment(\.managedObjectContext, CoreDataController.preview.mainContext)
    }
}
