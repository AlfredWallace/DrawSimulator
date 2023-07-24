//
//  RandomNumberProgressStyle.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 20/04/2023.
//

import Foundation
import SwiftUI

struct RandomNumberProgressStyle: ProgressViewStyle {

    func makeBody(configuration: Configuration) -> some View {
        return Text("\(Int.random(in: 0..<100))")
    }
}
