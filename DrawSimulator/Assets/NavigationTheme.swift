//
//  NavigationTheme.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/04/2023.
//

import Foundation
import SwiftUI
import UIKit

class NavigationTheme {
    static func navigationBarColors() {
        
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.defaultText)]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.defaultText)]
        
//        navigationAppearance.configureWithDefaultBackground()
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
//        UINavigationBar.appearance().compactAppearance = navigationAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
//        UINavigationBar.appearance().tintColor = UIColor(Color.defaultText)
//        UINavigationBar.appearance().barTintColor = UIColor(Color.defaultText)
    }
}
