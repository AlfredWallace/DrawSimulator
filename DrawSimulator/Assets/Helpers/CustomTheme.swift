//
//  NavigationTheme.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/04/2023.
//

import Foundation
import SwiftUI
import UIKit

struct CustomTheme {
    static func setColors() {

        let navigationAppearance = UINavigationBarAppearance()

        // Colors of navigationTitles
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.blueTheme)]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.blueTheme)]
        UINavigationBar.appearance().standardAppearance = navigationAppearance

        // Color of role-less buttuns on confirmationDialog and alerts
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.blueTheme)
    }
}
