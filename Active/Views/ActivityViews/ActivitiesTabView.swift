//
//  ActivitiesTabView.swift
//  Active
//
//  Created by Emrah on 2022-12-04.
//

import SwiftUI

struct ActivitiesTabView: View {
    @StateObject var categoryViewModel = CategoryViewModel()
    @StateObject var activityTypeViewModel = ActivityTypeViewModel()
    @StateObject var popularActivityTypeViewModel = ActivityTypeViewModel(sort: "popularity")
    private let popularActivityTypeLimit:Int = 10
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                switch categoryViewModel.fetchState{
                case .error(let message):
                    VStack(spacing: 10){
                        HStack{
                            Image(systemName: "exclamationmark.octagon.fill")
                                .font(.caption)
                                .foregroundColor(.red)
                            Text(message)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        Button {
                            categoryViewModel.fetch()
                            activityTypeViewModel.fetch()
                            popularActivityTypeViewModel.fetch()
                        } label: {
                            Text("Try Again")
                                .font(.caption)
                                .bold()
                        }
                    }
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                        .padding()
                case .idle, .loadedAll:
                    ScrollView(showsIndicators: false){
                        LazyVStack(spacing: 20){
                            Section {
                                CategoryGridView(categories: categoryViewModel.categories)
                            } header: {
                                HStack{
                                    Text("Browse Categories")
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                }
                            }
                            Section {
                                PopularActivityGridView(activityTypes: Array(popularActivityTypeViewModel.activityTypes.prefix(popularActivityTypeLimit)))
                            } header: {
                                HStack{
                                    Text("Popular Activities")
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Activities")
            .navigationBarTitleDisplayMode(.automatic)
            .padding(.top, -16)
        }
        .refreshable {
            activityTypeViewModel.fetch()
            popularActivityTypeViewModel.fetch()
            categoryViewModel.fetch()
        }
        .searchable(text: $activityTypeViewModel.searchTerm, placement: .navigationBarDrawer(displayMode: .automatic))
        .disableAutocorrection(true)
        .searchSuggestions({
            if !activityTypeViewModel.searchTerm.trim().isEmpty{
                ActivityTypeSearchSuggestionsView(activityTypes: $activityTypeViewModel.activityTypes)
            }
        })
    }
}

struct ActivitiesTabView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesTabView()
    }
}
