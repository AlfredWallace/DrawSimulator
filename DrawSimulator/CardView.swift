//
//  CardView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 18/04/2023.
//

import SwiftUI

struct CardView<Content: View, HeaderContent: View, FooterContent: View>: View {
    let content: () -> Content
    let header: () -> HeaderContent?
    let footer: () -> FooterContent?
    let hasHeaderDivider: Bool
    let hasFooterDivider: Bool
    
    init(
        hasHeaderDivier: Bool = false,
        hasFooterDivider: Bool = false,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> HeaderContent = { EmptyView() },
        @ViewBuilder footer: @escaping () -> FooterContent = { EmptyView() }
    ) {
        self.hasHeaderDivider = hasHeaderDivier
        self.hasFooterDivider = hasFooterDivider
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
        .carded()
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(hasHeaderDivier: true, hasFooterDivider: true) {
            Text("content")
        } header: {
            Text("head")
        } footer: {
            Text("foot")
        }
    }
}
