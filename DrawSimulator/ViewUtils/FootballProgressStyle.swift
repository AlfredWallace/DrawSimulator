//
//  FootballProgressStyle.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 19/04/2023.
//

import Foundation
import SwiftUI

struct FootballProgressStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let fraction = configuration.fractionCompleted ?? 0.0
        
        return HStack {
            Image(systemName: "soccerball")
                .rotationEffect(.degrees(fraction * 360 * 3))
        }
    }
}
