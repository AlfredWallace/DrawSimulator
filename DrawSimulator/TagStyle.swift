//
//  TeamListInfoViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 11/04/2023.
//

import Foundation
import SwiftUI

struct TagStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
}

extension View {
    func tagStyled() -> some View {
        modifier(TagStyle())
    }
}
