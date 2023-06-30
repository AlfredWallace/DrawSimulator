//
//  DividerView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .fill(Color.blueTheme)
            .frame(height: 1)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
