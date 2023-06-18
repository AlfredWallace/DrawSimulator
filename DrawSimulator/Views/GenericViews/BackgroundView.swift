//
//  BackgroundView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 18/06/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Rectangle()
            .fill(Color.pitchGreen.gradient)
            .ignoresSafeArea()
    }
}
