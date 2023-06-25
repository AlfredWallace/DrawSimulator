//
//  SectionTitleStyleView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 25/06/2023.
//

import SwiftUI

struct SectionTitleStyleView: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.title2.bold())
            .foregroundColor(.pitchGreen)
    }
}

struct SectionTitleStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleStyleView("My Section")
    }
}
