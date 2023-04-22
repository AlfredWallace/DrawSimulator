//
//  Countries.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 18/04/2023.
//

import Foundation

class Countries {
    private static let countriesArray: [Country] = Bundle.main.jsonDecode("countries.json")
    
    static var data: [Int: Country] {
        var result = [Int: Country]()
        countriesArray.forEach {
            result[$0.id] = $0
        }
        return result
    }
}
