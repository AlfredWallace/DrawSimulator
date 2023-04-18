//
//  DynamicTypeStack.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 19/04/2023.
//

import SwiftUI

struct DynamicTypeStack<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let vStackTypeSize: DynamicTypeSize
    let content: () -> Content
    
    init(_ vStackTypeSize: DynamicTypeSize = .accessibility1, @ViewBuilder content: @escaping () -> Content) {
        self.vStackTypeSize = vStackTypeSize
        self.content = content
    }
    
    var body: some View {
        if dynamicTypeSize >= vStackTypeSize {
            VStack {
                content()
            }
        } else {
            HStack {
                content()
            }
        }
    }
}
