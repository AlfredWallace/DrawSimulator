//
//  FileManager-DocumentsDirectory.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 29/03/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
