//
//  SeasonSectionTitleView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/06/2023.
//

import SwiftUI

struct SeasonSectionTitleView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    
    let sectionId: String
    
    private var title: String {
        switch userSettings.data.grouping {
            case .country:
                return sectionId
            case .none:
                return sectionId
            case .seeding:
                return sectionId
            default:
                return "Pool \(sectionId)"
        }
    }
    
    var body: some View {
        Text(title)
            .font(.title.bold())
            .foregroundColor(.pitchGreen)
    }
}

struct SeasonSectionTitleView_Previews: PreviewProvider {
    
    static let previewData: [(String, UserSettings.Grouping)] = [
        (sectionId: "A", grouping: .pool),
        (sectionId: "France", grouping: .country),
        (sectionId: "Seeded", grouping: .seeding),
        (sectionId: "2023", grouping: .none),
    ]
    
    static var previews: some View {
        
        SeasonSectionTitleView(sectionId: "A")
            .environmentObject({ () -> UserSettings in
                let userSettings = UserSettings()
                userSettings.setGrouping(.pool)
                return userSettings
            }())
        
        SeasonSectionTitleView(sectionId: "France")
            .environmentObject({ () -> UserSettings in
                let userSettings = UserSettings()
                userSettings.setGrouping(.country)
                return userSettings
            }())
        
        SeasonSectionTitleView(sectionId: "Seeded")
            .environmentObject({ () -> UserSettings in
                let userSettings = UserSettings()
                userSettings.setGrouping(.seeding)
                return userSettings
            }())
        
        SeasonSectionTitleView(sectionId: "2023")
            .environmentObject({ () -> UserSettings in
                let userSettings = UserSettings()
                userSettings.setGrouping(.none)
                return userSettings
            }())
    }
}
