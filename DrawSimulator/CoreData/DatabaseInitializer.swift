//
//  DatabaseInitializer.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/04/2023.
//

import Foundation
import CoreData

class DatabaseInitializer: ObservableObject {
    func initCountries(moc: NSManagedObjectContext) {
        let countries = [
            (name: "Italy", shortName: "ITA"),
            (name: "Spain", shortName: "SPA"),
            (name: "France", shortName: "FRA"),
            (name: "England", shortName: "ENG"),
            (name: "Belgium", shortName: "BEL"),
            (name: "Germany", shortName: "GER"),
            (name: "Portugal", shortName: "POR")
        ]
        
        for country in countries {
            let object = Country(context: moc)
            object.name = country.name
            object.shortName = country.shortName
        }
    }
    
    func initTeams(moc: NSManagedObjectContext) {
        let teams = [
            (name: "Paris Saint-Germain", shortName: "PSG", sortingName: "Paris"),
            (name: "SSC Napoli", shortName: "NAP", sortingName: "Napoli"),
            (name: "Liverpool FC", shortName: "LIV", sortingName: "Liverpool"),
            (name: "FC Porto", shortName: "POR", sortingName: "Porto"),
            (name: "Club Brugge", shortName: "BRU", sortingName: "Brugge"),
            (name: "Bayern München", shortName: "BAY", sortingName: "Bayern"),
            (name: "Inter Milan", shortName: "INT", sortingName: "Inter"),
            (name: "Tottenham Hotspur", shortName: "TOT", sortingName: "Tottenham"),
            (name: "Eintracht Frankfurt", shortName: "FRK", sortingName: "Frankfurt"),
            (name: "Chelsea FC", shortName: "CHE", sortingName: "Chelsea"),
            (name: "AC Milan", shortName: "ACM", sortingName: "Milan"),
            (name: "Real Madrid", shortName: "RMA", sortingName: "Real"),
            (name: "RB Leipzig", shortName: "RBL", sortingName: "Leipzig"),
            (name: "Manchester City", shortName: "MCI", sortingName: "ManCity"),
            (name: "Borussia Dortmund", shortName: "BVB", sortingName: "Dortmund"),
            (name: "SL Benfica", shortName: "BEN", sortingName: "Benfica"),
        ]
        
        for team in teams {
            let object = Team(context: moc)
            object.name = team.name
            object.shortName = team.shortName
            object.sortingName = team.sortingName
        }
    }
}
