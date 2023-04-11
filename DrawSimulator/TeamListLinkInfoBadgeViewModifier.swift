//
//  TeamListLinkInfoBadgeViewModifier.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 11/04/2023.
//

import Foundation
import SwiftUI

struct TeamListLinkInfoBadgeViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.darkGray)
            .font(.callout)
            .background(.white)
            .clipShape(Circle())
    }
}

extension View {
    func teamListLinkInfoBadgeViewModifier() -> some View {
        modifier(TeamListLinkInfoBadgeViewModifier())
    }
}
