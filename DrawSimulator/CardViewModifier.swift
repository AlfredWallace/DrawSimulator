//
//  CardViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import Foundation
import SwiftUI

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.shadow(.drop(radius: 5, y: 5)))
                    .foregroundStyle(Color.defaultBackground)
            )
    }
}

extension View {
    func carded() -> some View {
        modifier(CardViewModifier())
    }
}
