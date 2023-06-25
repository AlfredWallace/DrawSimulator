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
            title: "Variable results",
            content:
"""
Between one draw and another, you will likely see different results, usually between 1 or 2 percentage points.

This is expected: to be extremely accurate, it would take too much time.
"""
        ),
        
        SectionInfo(
            title: "Total other than 100%",
            content:
"""
When adding the percentages from a draw, you may not get a total of 100%.

This is expected: results are rounded, which can lead to some small mistakes.
"""
        ),
        
        SectionInfo(
            title: "Fonts credit",
            content:
"""
The font used for the team names in team lists is Chillax, provided by Indian Type Foundry through their website www.fontshare.com
"""
        ),
        
        SectionInfo(
            title: "Images credit",
            content:
"""
All team logos and country flags come from the corresponding Wikipedia pages.
"""
        ),
        
        SectionInfo(
            title: "Thanks",
            content:
"""
This is my fist iOS app, nothing would've been possible without the quality of Paul Hudson's Hacking With Swift course.
"""
        )
    ]
    
    var body: some View {
        NavigationStack {
            List(sections, id: \.self) { section in
                Section {
                    Text(section.content)
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

