//
//  IterableEnum.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 27/06/2023.
//

import Foundation

protocol IterableEnum: Identifiable, CaseIterable {

}

extension IterableEnum {
    var id: Self { self }
}
