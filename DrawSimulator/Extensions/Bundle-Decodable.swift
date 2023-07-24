//
//  Bundle-Decodable.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 18/10/2022.
//  Thanks to Paul Hudson @twostraws hacking with swift training
//

import Foundation

extension Bundle {

    func jsonDecode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }

}
