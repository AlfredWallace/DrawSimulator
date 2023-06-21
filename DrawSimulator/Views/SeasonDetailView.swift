//
//  SeasonDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 07/04/2023.
//

import SwiftUI
import CoreData

struct SeasonDetailView: View {
    
    @EnvironmentObject private var userSettings: UserSettings
    
    let season: Season
    
    @State private var showingGroupingDialog = false
    @State private var showingList = true
    
    @SectionedFetchRequest private var seasonTeamsByPool: SectionedFetchResults<String, SeasonTeam>
    @SectionedFetchRequest private var seasonTeamsBySeeding: SectionedFetchResults<String, SeasonTeam>
    @SectionedFetchRequest private var seasonTeamsByCountry: SectionedFetchResults<String, SeasonTeam>
    @SectionedFetchRequest private var seasonTeamsUngrouped: SectionedFetchResults<String, SeasonTeam>
    
    init(season: Season) {
        self.season = season
        
        // force unwrap is possible because the data is fully checked before being inserted into DB (see DatabaseInitializer)
        
        _seasonTeamsByPool = SectionedFetchRequest(
            sectionIdentifier: \.poolName,
            sortDescriptors: [SortDescriptor(\.poolName), SortDescriptor(\.seeded, order: .reverse)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _seasonTeamsBySeeding = SectionedFetchRequest(
            sectionIdentifier: \.seededString,
            sortDescriptors: [SortDescriptor(\.seeded, order: .reverse), SortDescriptor(\.team!.sortingName)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _seasonTeamsByCountry = SectionedFetchRequest(
            sectionIdentifier: \.team!.country!.name,
            sortDescriptors: [SortDescriptor(\.team!.country!.name), SortDescriptor(\.team!.sortingName)],
            predicate: NSPredicate(format: "season == %@", season)
        )
        
        _seasonTeamsUngrouped = SectionedFetchRequest(
            sectionIdentifier: \.season!.winYearString,
            sortDescriptors: [SortDescriptor(\.team!.sortingName)],
            predicate: NSPredicate(format: "season == %@", season)
        )
    }
    
    
    private var seasonTeams: SectionedFetchResults<String, SeasonTeam> {
        switch userSettings.data.grouping {
            case .country:
                return seasonTeamsByCountry
            case .none:
                return seasonTeamsUngrouped
            case .seeding:
                return seasonTeamsBySeeding
            default:
                return seasonTeamsByPool
        }
    }
    
    var body: some View {
        VStack {
            if showingList {
                
                List(seasonTeams) { section in
                    Section {
                        ForEach(section) { seasonTeam in
                            NavigationLink(value: seasonTeam) {
                                TeamLabelView(team: seasonTeam.team!, textStyle: .title2)
                            }
                        }
                    } header: {
                        SeasonSectionTitleView(sectionId: section.id)
                    }
                    .listRowSeparatorTint(.pitchGreen)
                }
                .navigationDestination(for: SeasonTeam.self) { seasonTeam in
                    TeamDetailView(seasonTeam: seasonTeam)
                }
                .navigationTitle("Teams")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        GroupingDialogButtonView(showingDialg: $showingGroupingDialog)
                            .foregroundColor(.pitchGreen)
                    }
                }
                .confirmationDialog("Change team grouping", isPresented: $showingGroupingDialog) {
                    GroupingDialogChoiceView(grouping: .pool, showingList: $showingList)
                    GroupingDialogChoiceView(grouping: .country, showingList: $showingList)
                    GroupingDialogChoiceView(grouping: .seeding, showingList: $showingList)
                    GroupingDialogChoiceView(grouping: .none, showingList: $showingList)
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
}


struct SeasonDetailView_Previews: PreviewProvider {
    
    static var userSettings = UserSettings()
    static var geoSizeTracker = GeoSizeTracker()
    
    static var previews: some View {
        
        let moc = CoreDataController.preview.mainContext
        let season = PreviewDataFetcher.fetchData(for: Season.self)
        
        return ZStack {
            GeometryReader { geoWrapper in
                Spacer()
                    .onAppear {
                        geoSizeTracker.setSize(geoWrapper.size)
                    }
            }
            
            NavigationStack {
                SeasonDetailView(season: season)
            }
            
        }
        .environment(\.managedObjectContext, moc)
        .environmentObject(userSettings)
        .environmentObject(geoSizeTracker)
        .tint(.defaultText)
    }
}
