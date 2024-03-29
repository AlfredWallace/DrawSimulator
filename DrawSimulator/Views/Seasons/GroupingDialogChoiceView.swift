//
//  GroupingDialogChoiceView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 15/04/2023.
//

import SwiftUI

struct GroupingDialogChoiceView: View {

    @EnvironmentObject private var userSettings: UserSettings

    let newGroupingValue: UserSettings.Grouping

    @Binding var showingList: Bool

    private let duration = 0.3

    private var speed: Double { 1 / duration }

    private var label: String {
        switch newGroupingValue {
            case .pool:
                return "Group by pool"
            case .country:
                return "Group by country"
            case .seeding:
                return "Group by seeding"
            default:
                return "Do not group"
        }
    }

    var body: some View {
        Button(label) {
            withAnimation(.easeIn.speed(speed)) {
                showingList.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                userSettings.grouping = newGroupingValue

                withAnimation(.easeOut.speed(speed)) {
                    showingList.toggle()
                }
            }
        }
    }
}
