//
//  CardView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 18/04/2023.
//

import SwiftUI

struct CardView<Content: View, HeaderContent: View, FooterContent: View, BackgroundOverlay: ShapeStyle>: View {
    let hasHeaderDivider: Bool
    let hasFooterDivider: Bool
    let backgroundOverlay: BackgroundOverlay
    let content: () -> Content
    let header: () -> HeaderContent?
    let footer: () -> FooterContent?
    
    init(
        hasHeaderDivier: Bool = false,
        hasFooterDivider: Bool = false,
        backgroundOverlay: BackgroundOverlay = Color.defaultBackground,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> HeaderContent = { EmptyView() },
        @ViewBuilder footer: @escaping () -> FooterContent = { EmptyView() }
    ) {
        self.hasHeaderDivider = hasHeaderDivier
        self.hasFooterDivider = hasFooterDivider
        self.backgroundOverlay = backgroundOverlay
        self.content = content
        self.header = header
        self.footer = footer
    }
    
    var body: some View {
        VStack {
            header()
            if hasHeaderDivider { DividerView() }
            content()
            if hasFooterDivider { DividerView() }
            footer()
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.strokeGray, lineWidth: 3)
                .foregroundStyle(Color.defaultBackground)
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(backgroundOverlay)
                }
        )
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(hasHeaderDivier: true, hasFooterDivider: true, backgroundOverlay: Color.blue.gradient) {
            Text("content")
        } header: {
            Text("head")
        } footer: {
            Text("foot")
        }
    }
}
