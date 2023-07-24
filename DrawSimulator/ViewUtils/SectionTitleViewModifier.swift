//
//  SectionTitleViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 25/06/2023.
//

import Foundation
import SwiftUI

struct SectionTitleViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title3.bold())
            .foregroundColor(.blueTheme)
    }
}

extension View {
    func sectionTitle() -> some View {
        modifier(SectionTitleViewModifier())
    }
}
