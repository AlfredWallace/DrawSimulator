//
//  NavigationStackActionButtonLabelViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 25/06/2023.
//

import Foundation
import SwiftUI

struct NavigationStackActionButtonLabelViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .labelStyle(.titleAndIcon)
            .foregroundColor(Color.pitchGreen)
    }
}

extension Label {
    func navigationStackActionButtonLabel() -> some View {
        modifier(NavigationStackActionButtonLabelViewModifier())
    }
}
