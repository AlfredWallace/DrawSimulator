//
//  AboutView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/06/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Info")
            }
            .navigationTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
