//
//  AboutView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/06/2023.
//

import SwiftUI

struct AboutView: View {
    
    private struct SectionInfo: Hashable {
        let title: String
        let content: String
    }
    
    private let sections = [
        SectionInfo(
            title: "Changing results",
            content:
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
        ),
        
        SectionInfo(
            title: "Total other than 100%",
            content:
"""
This is expected: results are rounded, so, sometimes it doesn't add up to 100%.
"""
        ),
        
        SectionInfo(
            title: "Fonts credit",
            content:
"""
The font used for the team names in team lists is Chillax, provided by Indian Type Foundry through their website www.fontshare.com
"""
        )
    ]
    
    var body: some View {
        NavigationStack {
            List(sections, id: \.self) { section in
                Section {
                    Text(section.content)
                    .allowsTightening(true)
                } header: {
                    SectionTitleStyleView(section.title)
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
