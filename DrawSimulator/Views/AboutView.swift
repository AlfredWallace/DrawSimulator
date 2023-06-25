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
                Section {
                    Text(
"""
When running a draw several times, you will likely see different results, usually between 1 or 2 percentage points, for instance:

First draw:

- Manchester City 33 %
- Bayern 27 %
- Real 40%

Second draw:

- Manchester City 31 %
- Bayern 28 %
- Real 41%

This is expected: to be extremely accurate, it would take too much time.
"""
                    )
                    .allowsTightening(true)
                } header: {
                    SectionTitleStyleView("Changing results")
                }
                
                Section {
                    Text(
"""
This is expected: results are rounded, so, sometimes it doesn't add up to 100%.
"""
                    )
                } header: {
                    SectionTitleStyleView("Total other than 100%")
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
