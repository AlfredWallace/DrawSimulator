//
//  ButtonProgressStyle.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 19/04/2023.
//

import Foundation
import SwiftUI

struct ButtonProgressStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let fraction = configuration.fractionCompleted ?? 0.0
        
        return Text("Calculating")
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: .pitchGreen, location: fraction),
                                .init(color: .defaultBackground, location: fraction)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.pitchGreen, lineWidth: 3)
                    }
            )
            .foregroundColor(Color.defaultText)
            .font(.title2.bold())
    }
}
