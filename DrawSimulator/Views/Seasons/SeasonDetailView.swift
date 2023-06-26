//
//  SeasonDetailView.swift
//  DrawSimulator
//
//  Created by Arthur Falque Pierrotin on 07/04/2023.
//

import SwiftUI
import CoreData

struct SeasonDetailView: View {
    
    @AppStorage("grouping") private var grouping = UserSettings.Grouping.pool
    
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
            sectionIdentifier: \.fullPoolName,
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
        switch grouping {
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
    
    private var groupingButtonLabel: String {
        switch grouping {
            case .country:
                return "Grouped by country"
            case .pool:
                return "Grouped by pool"
            case .seeding:
                return "Grouped by seeding"
            default:
                return "Ungrouped"
        }
    }
    
    private var groupingButtonIcon: String {
        switch grouping {
            case .country:
                return "flag"
            case .pool:
                return "list.bullet.below.rectangle"
            case .seeding:
                return "checklist"
            default:
                return "list.dash"
        }
    }
    
    var body: some View {
        ZStack {
            if showingList {
                List (seasonTeams) { section in
                    Section {
                        ForEach(section) { seasonTeam in
                            NavigationLink(value: seasonTeam) {
                                TeamLabelView(team: seasonTeam.team!, textStyle: .title2)
                            }
                        }
                    } header: {
                        Text(section.id)
                            .sectionTitle()
                    }
                    .listRowSeparatorTint(.pitchGreen)
                }
                // little trick to prevent the floating button to overlap the last item
                .safeAreaInset(edge: .bottom, spacing: 50) {
                    Text("")
                }
                .navigationDestination(for: SeasonTeam.self) { seasonTeam in
                    TeamDetailView(seasonTeam: seasonTeam)
                }
                .navigationTitle("Teams")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            showingGroupingDialog = true
                        } label: {
                            Label(groupingButtonLabel, systemImage: groupingButtonIcon)
                                .navigationStackActionButtonLabel()
                        }
                    }
                }
                .confirmationDialog("Change team grouping", isPresented: $showingGroupingDialog) {
                    GroupingDialogChoiceView(localGrouping: .pool, showingList: $showingList)
                    GroupingDialogChoiceView(localGrouping: .country, showingList: $showingList)
                    GroupingDialogChoiceView(localGrouping: .seeding, showingList: $showingList)
                    GroupingDialogChoiceView(localGrouping: .none, showingList: $showingList)
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
}


struct SeasonDetailView_Previews: PreviewProvider {
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
            
            TabView {
                NavigationStack {
                    SeasonDetailView(season: season)
                }
                .tabItem {
                    Text("dummy dummy dummy")
                }
            }
            
        }
        .environment(\.managedObjectContext, moc)
        .environmentObject(geoSizeTracker)
        .tint(.defaultText)
    }
}
