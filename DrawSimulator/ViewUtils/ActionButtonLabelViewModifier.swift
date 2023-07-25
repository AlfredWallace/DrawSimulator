//
//  ActionButtonLabelViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 25/06/2023.
//

import Foundation
import SwiftUI

struct ActionButtonLabelViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title2)
            .labelStyle(.titleAndIcon)
            .foregroundColor(Color.blueTheme)
    }
}

extension Label {
    func actionButtonLabel() -> some View {
        modifier(ActionButtonLabelViewModifier())
    }
}
