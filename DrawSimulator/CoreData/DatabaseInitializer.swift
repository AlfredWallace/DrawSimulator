//
//  DatabaseInitializer.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 24/04/2023.
//

import Foundation
import CoreData

struct DatabaseInitializer {
    
    static let shared = DatabaseInitializer()
    
    private let genericErrorMsg = "Hard coded data is invalid."
    
    enum CountryIdentifier: String {
        case ITA, SPA, FRA, ENG, BEL, GER, POR
    }
    
    enum TeamIdentifier: String {
        case PSG, NAP, LIV, FCP, BRU, BAY, INT, TOT, FRK, CHE, ACM, RMA, RBL, MCI, BVB, BEN
    }
    
    private struct TeamData {
        let name: String
        let sortingName: String
        let countryIdentifier: CountryIdentifier
    }
    
    private struct SeasonTeamData {
        let poolName: String
        let seeded: Bool
        let teamIdentifier: TeamIdentifier
        let seasonWinYear: Int
    }
    
    private let seasonData = [
        2023: (city: "Istanbul", stadium: "Atatürk Olympic Stadium")
    ]
    
    private let countryData = [
        CountryIdentifier.ITA : "Italy",
        CountryIdentifier.SPA : "Spain",
        CountryIdentifier.FRA : "France",
        CountryIdentifier.ENG : "England",
        CountryIdentifier.BEL : "Belgium",
        CountryIdentifier.GER : "Germany",
        CountryIdentifier.POR : "Portugal",
    ]

    private let teamData = [
        TeamIdentifier.PSG: TeamData(name: "Paris Saint-Germain", sortingName: "Paris", countryIdentifier: CountryIdentifier.FRA),
        TeamIdentifier.NAP: TeamData(name: "SSC Napoli", sortingName: "Napoli", countryIdentifier: CountryIdentifier.ITA),
        TeamIdentifier.LIV: TeamData(name: "Liverpool FC", sortingName: "Liverpool", countryIdentifier: CountryIdentifier.ENG),
        TeamIdentifier.FCP: TeamData(name: "FC Porto", sortingName: "Porto", countryIdentifier: CountryIdentifier.POR),
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

    private let seasonTeamData = [
        SeasonTeamData(poolName: "A", seeded: true, teamIdentifier: TeamIdentifier.NAP, seasonWinYear: 2023),
        SeasonTeamData(poolName: "A", seeded: false, teamIdentifier: TeamIdentifier.LIV, seasonWinYear: 2023),
        SeasonTeamData(poolName: "B", seeded: true, teamIdentifier: TeamIdentifier.FCP, seasonWinYear: 2023),
        SeasonTeamData(poolName: "B", seeded: false, teamIdentifier: TeamIdentifier.BRU, seasonWinYear: 2023),
        SeasonTeamData(poolName: "C", seeded: true, teamIdentifier: TeamIdentifier.BAY, seasonWinYear: 2023),
        SeasonTeamData(poolName: "C", seeded: false, teamIdentifier: TeamIdentifier.INT, seasonWinYear: 2023),
        SeasonTeamData(poolName: "D", seeded: true, teamIdentifier: TeamIdentifier.TOT, seasonWinYear: 2023),
        SeasonTeamData(poolName: "D", seeded: false, teamIdentifier: TeamIdentifier.FRK, seasonWinYear: 2023),
        SeasonTeamData(poolName: "E", seeded: true, teamIdentifier: TeamIdentifier.CHE, seasonWinYear: 2023),
        SeasonTeamData(poolName: "E", seeded: false, teamIdentifier: TeamIdentifier.ACM, seasonWinYear: 2023),
        SeasonTeamData(poolName: "F", seeded: true, teamIdentifier: TeamIdentifier.RMA, seasonWinYear: 2023),
        SeasonTeamData(poolName: "F", seeded: false, teamIdentifier: TeamIdentifier.RBL, seasonWinYear: 2023),
        SeasonTeamData(poolName: "G", seeded: true, teamIdentifier: TeamIdentifier.MCI, seasonWinYear: 2023),
        SeasonTeamData(poolName: "G", seeded: false, teamIdentifier: TeamIdentifier.BVB, seasonWinYear: 2023),
        SeasonTeamData(poolName: "H", seeded: true, teamIdentifier: TeamIdentifier.BEN, seasonWinYear: 2023),
        SeasonTeamData(poolName: "H", seeded: false, teamIdentifier: TeamIdentifier.PSG, seasonWinYear: 2023),
    ]
    
    func makeSeason(_ moc: NSManagedObjectContext, _ winYear: Int) {
        
        // If validation checks out, you can force unwrap everything
        validateSeason(winYear)

        let season = Season(context: moc, winYear: winYear, city: seasonData[winYear]!.city, stadium: seasonData[winYear]!.stadium)
        
        var countries = Set<Country>()
        
        for oneSeasonTeam in seasonTeamData {
            let teamData = teamData[oneSeasonTeam.teamIdentifier]!
            let countryIdentifier = teamData.countryIdentifier
            
            var country = countries.first(where: { $0.shortName == countryIdentifier.rawValue })
            // If we can't find the country, then it's the first time we encounter this one, so, we insert it
            if country == nil {
                country = Country(context: moc, name: countryData[countryIdentifier]!, shortName: countryIdentifier.rawValue)
                countries.insert(country!)
            }
            
            let team = Team(
                context: moc,
                name: teamData.name,
                shortName: oneSeasonTeam.teamIdentifier.rawValue,
                sortingName: teamData.sortingName,
                country: country
            )
            
            let seasonTeam = SeasonTeam(
                context: moc,
                poolName: oneSeasonTeam.poolName,
                seeded: oneSeasonTeam.seeded,
                season: season,
                team: team
            )
            
            team.addToSeasonTeams(seasonTeam)
            season.addToSeasonTeams(seasonTeam)
            country!.addToTeams(team)
        }
    }
    
    private func validateSeason(_ winYear: Int) {
        
        // Checking if season exists
        if seasonData[winYear] == nil {
            fatalError("\(genericErrorMsg) There is no season \(winYear).")
        }
        
        let seasonTeams = seasonTeamData.filter({ $0.seasonWinYear == winYear })
        let seasonTeamsCount = seasonTeams.count
        let teamCount = 16
        
        // Checking if the number if teeamPool associations is 16
        if seasonTeamsCount != teamCount {
            fatalError("\(genericErrorMsg) There has to be \(teamCount) seasonTeam associations for one season. Season \(winYear) currently has \(seasonTeamsCount).")
        }
        
        // Checking if we have 16 different teams
        if Set(seasonTeams.map({ $0.teamIdentifier })).count != teamCount {
            fatalError("\(genericErrorMsg) There cannot be team duplicates in the seasonTeams.")
        }
        
        // Grouping by pool name allows us to check:
        // - if we have 8 associations of 2 teams
        // - if we have, in each association, a seeded team and an unseeded one
        for pool in Dictionary(grouping: seasonTeams, by: { $0.poolName }) {
            let seasonTeamsAssociations = pool.value
            
            // checking associations of 2 teams
            if seasonTeamsAssociations.count != 2 {
                fatalError("\(genericErrorMsg) There has to be exactly 2 seasonTeam associations of the same pool name.")
            }
            
            // checking seedings
            if seasonTeamsAssociations[0].seeded == seasonTeamsAssociations[1].seeded {
                fatalError("\(genericErrorMsg) The 2 seasonTeam associations of a same pool name have to have different seedings.")
            }
        }
    
        
        // For readability reasons we will check for the rest in 2 other loops :
        
        
        var countriesToCheck = Set<CountryIdentifier>()
        // For each seasonTeam association we will check if the team exists, and save fot later the country identifier
        // This is a small optimization to prevent us from checking multiple times some countries
        for seasonTeam in seasonTeams {
            let teamIdentifier = seasonTeam.teamIdentifier
            
            guard let team = teamData[teamIdentifier] else {
                fatalError("\(genericErrorMsg) Team \(teamIdentifier) does not exist.")
            }
            
            countriesToCheck.insert(team.countryIdentifier)
        }
        
        if countriesToCheck.count == 0 {
            fatalError("\(genericErrorMsg) There are no countries.")
        }
        
        for countryIdentifier in countriesToCheck {
            if countryData[countryIdentifier] == nil {
                fatalError("\(genericErrorMsg) The country \(countryIdentifier) does not exist.")
            }
        }
    }
}
