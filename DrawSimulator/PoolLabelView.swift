//
//  PoolLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct PoolLabelView: View {
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let team: Team
    
    var body: some View {
        HStack {
            if dynamicTypeSize <= .xxxLarge {
                Text("Pool")
            }
            Image(systemName: "\(team.pool.lowercased()).circle.fill")
        }
    }
}

