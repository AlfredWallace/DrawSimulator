//
//  DynamicTypeStack.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 19/04/2023.
//

import SwiftUI

struct DynamicTypeStack<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ViewThatFits {
            HStack {
                content()
            }
            VStack {
                content()
            }
        }
    }
}
