//
//  SectionTitleView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 04/04/2023.
//

import SwiftUI

struct SectionTitleView: View {
    let team: Team
    let countriesDict: [Int: Country]
    @EnvironmentObject var configuration: Configuration
    
    var body: some View {
        Group {
            if configuration.grouping == .pool {
                HStack {
                    Text("Pool")
                    team.poolImage
                        .padding(2)
                        .background(.white)
                        .clipShape(Circle())
                }
            } else {
                Text(countriesDict[team.countryId]!.name)
            }
        }
        .font(.title2)
    }
}

//struct SectionTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionTitleView()
//    }
//}
