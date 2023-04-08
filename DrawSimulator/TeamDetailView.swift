//
//  TeamDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 01/04/2023.
//

import SwiftUI

struct TeamDetailView: View {
    let team: Team
    
    var body: some View {
        Text(team.name)
            .foregroundColor(.red)
    }
}

