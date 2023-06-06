//
//  GeoSizeTracker.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 14/04/2023.
//

import Foundation

@MainActor class GeoSizeTracker: ObservableObject {
    private var size: CGSize?
    
    func getSize() -> CGSize {
        guard let size = size else {
            return CGSize(width: 375.0, height: 850.0)
        }
        
        return size
    }
    
    func setSize(_ size: CGSize) {
        self.size = size
    }
}
