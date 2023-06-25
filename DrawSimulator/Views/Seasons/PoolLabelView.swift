//
//  PoolLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct PoolLabelView: View {
    
    let seasonTeam: SeasonTeam
    
    var body: some View {
        HStack {
            Text("Pool")
            Image(systemName: "\(seasonTeam.poolName.lowercased()).circle.fill")
        }
    }
}

