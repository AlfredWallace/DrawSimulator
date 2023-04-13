//
//  SharedConstants.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 08/04/2023.
//

import Foundation

struct SharedConstants {
    
    static let teams: [Team] = Bundle.main.jsonDecode("teams.json")
    
    private static let countriesArray: [Country] = Bundle.main.jsonDecode("countries.json")
    
    static var countries: [Int: Country] {
        var result = [Int: Country]()
        countriesArray.forEach {
            result[$0.id] = $0
        }
        return result
    }
    
    enum Chillax: String {
        case boldRegular = "ChillaxVariable-Bold_Regular"
        case boldExtralight = "ChillaxVariable-Bold_Extralight"
        case boldLight = "ChillaxVariable-Bold_Light"
        case boldMedium = "ChillaxVariable-Bold_Medium"
        case boldSemibold = "ChillaxVariable-Bold_Semibold"
        case bold = "ChillaxVariable-Bold"
    }
}
