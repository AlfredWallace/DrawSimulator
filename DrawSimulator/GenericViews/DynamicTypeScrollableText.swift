//
//  DynamicTypeScrollableText.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 02/05/2023.
//

import SwiftUI

struct DynamicTypeScrollableText: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        ViewThatFits {
            HStack {
                Text(text)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                Text(text)
            }
            .scrollIndicators(.hidden)
        }
        
    }
}
