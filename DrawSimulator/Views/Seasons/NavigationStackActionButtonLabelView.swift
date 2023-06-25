//
//  NavigationStackActionButtonLabelView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 25/06/2023.
//

import SwiftUI

struct NavigationStackActionButtonLabelView: View {
    let titleKey: String
    let systemImage: String
    
    init(_ titleKey: String, systemImage: String) {
        self.titleKey = titleKey
        self.systemImage = systemImage
    }
    
    var body: some View {
        Label(titleKey, systemImage: systemImage)
            .font(.title2)
            .labelStyle(.titleAndIcon)
            .foregroundColor(Color.pitchGreen)
    }
}

struct NavigationStackActionButtonLabelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackActionButtonLabelView("Hello World!", systemImage: "globe")
    }
}
