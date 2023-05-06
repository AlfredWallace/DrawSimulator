//
//  DatabaseInitializer.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/04/2023.
//

import Foundation
import CoreData

class DatabaseInitializer {
    
    static private let genericErrorMsg = "Hard coded data is invalid."
    
    enum CountryIdentifier: String {
        case ITA, SPA, FRA, ENG, BEL, GER, POR
    }
    
    enum TeamIdentifier: String {
        case PSG, NAP, LIV, POR, BRU, BAY, INT, TOT, FRK, CHE, ACM, RMA, RBL, MCI, BVB, BEN
    }
    
    private struct TeamData {
        let name: String
        let sortingName: String
        let countryIdentifier: CountryIdentifier
    }
    
    private struct TeamPoolData {
        let name: String
        let seeded: Bool
        let teamIdentifier: TeamIdentifier
        let seasonWinYear: Int
    }
    
    static private let seasonData = [
        2023: (city: "Istanbul", stadium: "Atatürk Olympic Stadium")
    ]
    
    static let countryData = [
        CountryIdentifier.ITA : "Italy",
        CountryIdentifier.SPA : "Spain",
        CountryIdentifier.FRA : "France",
        CountryIdentifier.ENG : "England",
        CountryIdentifier.BEL : "Belgium",
        CountryIdentifier.GER : "Germany",
        CountryIdentifier.POR : "Portugal",
    ]

    static private let teamData = [
        TeamIdentifier.PSG: TeamData(name: "Paris Saint-Germain", sortingName: "Paris", countryIdentifier: CountryIdentifier.FRA),
        TeamIdentifier.NAP: TeamData(name: "SSC Napoli", sortingName: "Napoli", countryIdentifier: CountryIdentifier.ITA),
        TeamIdentifier.LIV: TeamData(name: "Liverpool FC", sortingName: "Liverpool", countryIdentifier: CountryIdentifier.ENG),
        TeamIdentifier.POR: TeamData(name: "FC Porto", sortingName: "Porto", countryIdentifier: CountryIdentifier.POR),
        TeamIdentifier.BRU: TeamData(name: "Club Brugge", sortingName: "Brugge", countryIdentifier: CountryIdentifier.BEL),
        TeamIdentifier.BAY: TeamData(name: "Bayern München", sortingName: "Bayern", countryIdentifier: CountryIdentifier.GER),
        TeamIdentifier.INT: TeamData(name: "Inter Milan", sortingName: "Inter", countryIdentifier: CountryIdentifier.ITA),
        TeamIdentifier.TOT: TeamData(name: "Tottenham Hotspur", sortingName: "Tottenham", countryIdentifier: CountryIdentifier.ENG),
        TeamIdentifier.FRK: TeamData(name: "Eintracht Frankfurt", sortingName: "Frankfurt", countryIdentifier: CountryIdentifier.GER),
        TeamIdentifier.CHE: TeamData(name: "Chelsea FC", sortingName: "Chelsea", countryIdentifier: CountryIdentifier.ENG),
        TeamIdentifier.ACM: TeamData(name: "AC Milan", sortingName: "Milan", countryIdentifier: CountryIdentifier.ITA),
        TeamIdentifier.RMA: TeamData(name: "Real Madrid", sortingName: "Real", countryIdentifier: CountryIdentifier.SPA),
        TeamIdentifier.RBL: TeamData(name: "RB Leipzig", sortingName: "Leipzig", countryIdentifier: CountryIdentifier.GER),
        TeamIdentifier.MCI: TeamData(name: "Manchester City", sortingName: "ManCity", countryIdentifier: CountryIdentifier.ENG),
        TeamIdentifier.BVB: TeamData(name: "Borussia Dortmund", sortingName: "Dortmund", countryIdentifier: CountryIdentifier.GER),
        TeamIdentifier.BEN: TeamData(name: "SL Benfica", sortingName: "Benfica", countryIdentifier: CountryIdentifier.POR),
    ]

    static private let teamPoolData = [
        TeamPoolData(name: "A", seeded: true, teamIdentifier: TeamIdentifier.NAP, seasonWinYear: 2023),
        TeamPoolData(name: "A", seeded: false, teamIdentifier: TeamIdentifier.LIV, seasonWinYear: 2023),
        TeamPoolData(name: "B", seeded: true, teamIdentifier: TeamIdentifier.POR, seasonWinYear: 2023),
        TeamPoolData(name: "B", seeded: false, teamIdentifier: TeamIdentifier.BRU, seasonWinYear: 2023),
        TeamPoolData(name: "C", seeded: true, teamIdentifier: TeamIdentifier.BAY, seasonWinYear: 2023),
        TeamPoolData(name: "C", seeded: false, teamIdentifier: TeamIdentifier.INT, seasonWinYear: 2023),
        TeamPoolData(name: "D", seeded: true, teamIdentifier: TeamIdentifier.TOT, seasonWinYear: 2023),
        TeamPoolData(name: "D", seeded: false, teamIdentifier: TeamIdentifier.FRK, seasonWinYear: 2023),
        TeamPoolData(name: "E", seeded: true, teamIdentifier: TeamIdentifier.CHE, seasonWinYear: 2023),
        TeamPoolData(name: "E", seeded: false, teamIdentifier: TeamIdentifier.ACM, seasonWinYear: 2023),
        TeamPoolData(name: "F", seeded: true, teamIdentifier: TeamIdentifier.RMA, seasonWinYear: 2023),
        TeamPoolData(name: "F", seeded: false, teamIdentifier: TeamIdentifier.RBL, seasonWinYear: 2023),
        TeamPoolData(name: "G", seeded: true, teamIdentifier: TeamIdentifier.MCI, seasonWinYear: 2023),
        TeamPoolData(name: "G", seeded: false, teamIdentifier: TeamIdentifier.BVB, seasonWinYear: 2023),
        TeamPoolData(name: "H", seeded: true, teamIdentifier: TeamIdentifier.BEN, seasonWinYear: 2023),
        TeamPoolData(name: "H", seeded: false, teamIdentifier: TeamIdentifier.PSG, seasonWinYear: 2023),
    ]
    
    static func makeSeason(_ moc: NSManagedObjectContext, _ winYear: Int) -> Season {
        guard let seasonData = seasonData[winYear] else {
            fatalError("\(genericErrorMsg) There is no season \(winYear).")
        }
        
        let season = Season(context: moc, winYear: winYear, city: seasonData.city, stadium: seasonData.stadium)
        let seasonTeamPools = teamPoolData.filter({ $0.seasonWinYear == season.winYear })
        
        validateTeamPoolData(winYear, seasonTeamPools)
        
        var teamPools = [TeamPool]()
        for oneTeamPool in seasonTeamPools {
            teamPools.append(TeamPool(context: moc, name: oneTeamPool.name, seeded: oneTeamPool.seeded, season: season))
        }
        
        return season
    }
    
    static private func validateTeamPoolData(_ winYear: Int, _ data: [TeamPoolData]) {
        let dataCount = data.count
        let teamCount = 16
        
        if dataCount != teamCount {
            fatalError("\(genericErrorMsg) There has to be \(teamCount) teamPool associations for one season. Season \(winYear) currently has \(dataCount).")
        }
        
        if Set(data.map({ $0.teamIdentifier })).count != teamCount {
            fatalError("\(genericErrorMsg) There cannot be team duplicates in the teamPools.")
        }
        
        for pool in Dictionary(grouping: data, by: { $0.name }) {
            let teamPoolAssociations = pool.value
            
            if teamPoolAssociations.count != 2 {
                fatalError("\(genericErrorMsg) There has to be exactly 2 teamPool associations of the same name.")
            }
            
            if teamPoolAssociations[0].seeded == teamPoolAssociations[1].seeded {
                fatalError("\(genericErrorMsg) The 2 teamPool associations of a same pool name have to have different seedings.")
            }
        }
    }
    
    init(_ moc: NSManagedObjectContext) {
        
        // SEASONS
        
//        for seasonTuple in seasonTuples {
//            let season = Season(context: moc, winYear: seasonTuple.winYear, city: seasonTuple.city, stadium: seasonTuple.stadium)
//            seasons[seasonTuple.winYear] = season
//        }
//        
//        // COUNTRIES
//        
//        for countryTuple in countryTuples {
//            let country = Country(context: moc, name: countryTuple.name, shortName: countryTuple.shortName.rawValue)
//            countries[countryTuple.shortName] = country
//        }
//        
//        // TEAMS
//        
//        for teamTuple in teamTuples {
//            let team = Team(context: moc, name: teamTuple.name, shortName: teamTuple.shortName.rawValue, sortingName: teamTuple.sortingName, country: teamTuple.country)
//            teams[teamTuple.shortName] = team
//        }
//        
//        // POOLS
//        
//        for teamPoolTuple in teamPoolTuples {
//            let _ = TeamPool(
//                context: moc,
//                name: teamPoolTuple.name,
//                seeded: teamPoolTuple.seeded,
//                season: teamPoolTuple.season,
//                team: teamPoolTuple.team
//            )
//        }
    }
}
