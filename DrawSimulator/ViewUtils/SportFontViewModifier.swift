//
//  SportFontViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 02/05/2023.
//

import Foundation
import SwiftUI

struct SportFontViewModifier: ViewModifier {

    static private func getFinalSize(for textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
            case .caption2:
                fallthrough
            case .caption:
                return 12
            case .footnote:
                return 13
            case .callout:
                fallthrough
            case .subheadline:
                return 15
            case .title3:
                return 18
            case .title2:
                return 21
            case .title:
                return 26
            case .largeTitle:
                return 30
            default:
                return 16
        }
    }

    let textStyle: Font.TextStyle
    let size: CGFloat

    init(textStyle: Font.TextStyle, multiplier: CGFloat) {
        self.textStyle = textStyle

        let finalSize = Self.getFinalSize(for: textStyle)

        if multiplier > 1 {
            size = finalSize * multiplier
        } else {
            size = finalSize
        }

    }

    func body(content: Content) -> some View {
        content
            .font(.custom(Fonts.Chillax.bold.rawValue, size: size, relativeTo: textStyle))
    }
}

extension View {
    func sportFont(_ textStyle: Font.TextStyle, multiplier: CGFloat = 1.0) -> some View {
        modifier(SportFontViewModifier(textStyle: textStyle, multiplier: multiplier))
    }
}
