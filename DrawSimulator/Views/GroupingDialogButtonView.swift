//
//  GroupingDialogButtonView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/04/2023.
//

import SwiftUI

struct GroupingDialogButtonView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    @Binding var showingDialg: Bool
    
    private var groupingLabelStrings: (title: String, icon: String) {
        switch userSettings.data.grouping {
            case .country:
                return ("Grouped by country", "flag")
            case .pool:
                return ("Grouped by pool", "list.bullet.below.rectangle")
            case .seeding:
                return ("Grouped by seeding", "checklist")
            default:
                return ("Ungrouped", "list.dash")
        }
    }
    
    var body: some View {
        Button {
            showingDialg = true
        } label: {
            Label(groupingLabelStrings.title, systemImage: groupingLabelStrings.icon)
                .labelStyle(.titleAndIcon)
        }
        .font(.title2)
        .padding(.top, 10)
    }
}

