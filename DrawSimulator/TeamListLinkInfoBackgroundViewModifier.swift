//
//  TeamListInfoViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 11/04/2023.
//

import Foundation
import SwiftUI

struct TeamListLinkInfoBackgroundViewModifier: ViewModifier {
    let geo: GeometryProxy
    let factor: CGFloat
    
    var size: CGFloat { geo.size.width * factor }
    
    func body(content: Content) -> some View {
        return content
            .frame(width: size, height: size)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

extension View {
    func teamListLinkInfoBackgroundViewModifier(_ geo: GeometryProxy, factor: CGFloat = 0.12) -> some View {
        modifier(TeamListLinkInfoBackgroundViewModifier(geo: geo, factor: factor))
    }
}
