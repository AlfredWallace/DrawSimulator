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
        let italy = Country(context: moc)
        italy.name = "Italy"
        italy.shortName = "ITA"
        
        let spain = Country(context: moc)
        spain.name = "Spain"
        spain.shortName = "SPA"
        
        let france = Country(context: moc)
        france.name = "France"
        france.shortName = "FRA"
        
        let england = Country(context: moc)
        england.name = "England"
        england.shortName = "ENG"
        
        let belgium = Country(context: moc)
        belgium.name = "Belgium"
        belgium.shortName = "BEL"
        
        let germany = Country(context: moc)
        germany.name = "Germany"
        germany.shortName = "GER"
        
        let portugal = Country(context: moc)
        portugal.name = "Portugal"
        portugal.shortName = "POR"
    }
}
