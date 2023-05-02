//
//  SportFontViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 02/05/2023.
//

import Foundation
import SwiftUI

struct SportFontViewModifier: ViewModifier {
    let textStyle: Font.TextStyle
    let size: CGFloat
    
    init(textStyle: Font.TextStyle, multiplier: CGFloat) {
        self.textStyle = textStyle
        
        var finalSize = 0.0
        
        switch textStyle {
            case .callout:
                finalSize = 15
            case .caption:
                finalSize = 12
            case .caption2:
                finalSize = 11
            case .footnote:
                finalSize = 13
            case .headline:
                finalSize = 16
            case .subheadline:
                finalSize = 15
            case .largeTitle:
                finalSize = 30
            case .title:
                finalSize = 26
            case .title2:
                finalSize = 21
            case .title3:
                finalSize = 18
            default:
                finalSize = 16
        }
        
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
