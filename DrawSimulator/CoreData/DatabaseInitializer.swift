//
//  DatabaseInitializer.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/04/2023.
//

import Foundation
import CoreData

class DatabaseInitializer: ObservableObject {
    
    enum CountryIdentifier: String {
        case ITA, SPA, FRA, ENG, BEL, GER, POR
    }
    
    enum TeamIdentifier: String {
        case PSG, NAP, LIV, POR, BRU, BAY, INT, TOT, FRK, CHE, ACM, RMA, RBL, MCI, BVB, BEN
    }
    
    func initialize(moc: NSManagedObjectContext) {
        
        // SEASONS
        let winYears = [
            2023
        ]
        
        var seasons = [Int: Season]()
        
        for winYear in winYears {
            let season = Season(context: moc)
            season.winYear = Int16(winYear)
            seasons[winYear] = season
        }
        
        // COUNTRIES
        let countryTuples = [
            (name: "Italy", shortName: CountryIdentifier.ITA),
            (name: "Spain", shortName: CountryIdentifier.SPA),
            (name: "France", shortName: CountryIdentifier.FRA),
            (name: "England", shortName: CountryIdentifier.ENG),
            (name: "Belgium", shortName: CountryIdentifier.BEL),
            (name: "Germany", shortName: CountryIdentifier.GER),
            (name: "Portugal", shortName: CountryIdentifier.POR),
        ]
        
        var countries = [CountryIdentifier: Country]()
        
        for countryTuple in countryTuples {
            let country = Country(context: moc)
            country.name = countryTuple.name
            country.shortName = countryTuple.shortName.rawValue
            countries[countryTuple.shortName] = country
        }
        
        // TEAMS
        let teamTuples = [
            (name: "Paris Saint-Germain", shortName: TeamIdentifier.PSG, sortingName: "Paris", country: countries[CountryIdentifier.FRA]),
            (name: "SSC Napoli", shortName: TeamIdentifier.NAP, sortingName: "Napoli", country: countries[CountryIdentifier.ITA]),
            (name: "Liverpool FC", shortName: TeamIdentifier.LIV, sortingName: "Liverpool", country: countries[CountryIdentifier.ENG]),
            (name: "FC Porto", shortName: TeamIdentifier.POR, sortingName: "Porto", country: countries[CountryIdentifier.POR]),
            (name: "Club Brugge", shortName: TeamIdentifier.BRU, sortingName: "Brugge", country: countries[CountryIdentifier.BEL]),
            (name: "Bayern München", shortName: TeamIdentifier.BAY, sortingName: "Bayern", country: countries[CountryIdentifier.GER]),
            (name: "Inter Milan", shortName: TeamIdentifier.INT, sortingName: "Inter", country: countries[CountryIdentifier.ITA]),
            (name: "Tottenham Hotspur", shortName: TeamIdentifier.TOT, sortingName: "Tottenham", country: countries[CountryIdentifier.ENG]),
            (name: "Eintracht Frankfurt", shortName: TeamIdentifier.FRK, sortingName: "Frankfurt", country: countries[CountryIdentifier.GER]),
            (name: "Chelsea FC", shortName: TeamIdentifier.CHE, sortingName: "Chelsea", country: countries[CountryIdentifier.ENG]),
            (name: "AC Milan", shortName: TeamIdentifier.ACM, sortingName: "Milan", country: countries[CountryIdentifier.ITA]),
            (name: "Real Madrid", shortName: TeamIdentifier.RMA, sortingName: "Real", country: countries[CountryIdentifier.SPA]),
            (name: "RB Leipzig", shortName: TeamIdentifier.RBL, sortingName: "Leipzig", country: countries[CountryIdentifier.GER]),
            (name: "Manchester City", shortName: TeamIdentifier.MCI, sortingName: "ManCity", country: countries[CountryIdentifier.ENG]),
            (name: "Borussia Dortmund", shortName: TeamIdentifier.BVB, sortingName: "Dortmund", country: countries[CountryIdentifier.GER]),
            (name: "SL Benfica", shortName: TeamIdentifier.BEN, sortingName: "Benfica", country: countries[CountryIdentifier.POR]),
        ]
        
        var teams = [TeamIdentifier: Team]()
        
        for teamTuple in teamTuples {
            let team = Team(context: moc)
            team.name = teamTuple.name
            team.shortName = teamTuple.shortName.rawValue
            team.sortingName = teamTuple.sortingName
            team.country = teamTuple.country
            teams[teamTuple.shortName] = team
        }
        
        // POOLS
        let teamPoolTuples = [
            (name: "A", seeded: true, team: teams[TeamIdentifier.NAP], season: seasons[2023]),
            (name: "A", seeded: false, team: teams[TeamIdentifier.LIV], season: seasons[2023]),
            (name: "B", seeded: true, team: teams[TeamIdentifier.POR], season: seasons[2023]),
            (name: "B", seeded: false, team: teams[TeamIdentifier.BRU], season: seasons[2023]),
            (name: "C", seeded: true, team: teams[TeamIdentifier.BAY], season: seasons[2023]),
            (name: "C", seeded: false, team: teams[TeamIdentifier.INT], season: seasons[2023]),
            (name: "D", seeded: true, team: teams[TeamIdentifier.TOT], season: seasons[2023]),
            (name: "D", seeded: false, team: teams[TeamIdentifier.FRK], season: seasons[2023]),
            (name: "E", seeded: true, team: teams[TeamIdentifier.CHE], season: seasons[2023]),
            (name: "E", seeded: false, team: teams[TeamIdentifier.ACM], season: seasons[2023]),
            (name: "F", seeded: true, team: teams[TeamIdentifier.RMA], season: seasons[2023]),
            (name: "F", seeded: false, team: teams[TeamIdentifier.RBL], season: seasons[2023]),
            (name: "G", seeded: true, team: teams[TeamIdentifier.MCI], season: seasons[2023]),
            (name: "G", seeded: false, team: teams[TeamIdentifier.BVB], season: seasons[2023]),
            (name: "H", seeded: true, team: teams[TeamIdentifier.BEN], season: seasons[2023]),
            (name: "H", seeded: false, team: teams[TeamIdentifier.PSG], season: seasons[2023]),
        ]
        
        for teamPoolTuple in teamPoolTuples {
            let teamPool = TeamPool(context: moc)
            teamPool.name = teamPoolTuple.name
            teamPool.seeded = teamPoolTuple.seeded
            teamPool.team = teamPoolTuple.team
            teamPool.season = teamPoolTuple.season
        }
    }
}
