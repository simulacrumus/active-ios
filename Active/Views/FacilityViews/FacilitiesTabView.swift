//
//  FacilitiesTabView.swift
//  Active
//
//  Created by Emrah on 2022-11-25.
//

import SwiftUI
import UIKit

struct FacilitiesTabView: View {
    
    @State private var searchText = ""
    @State var isSheetOpen:Bool = false
    
    @StateObject var facilityViewModel = FacilityViewModel()
    @StateObject var facilityViewModelForSearch = FacilityViewModel()

    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing:0, pinnedViews: [.sectionHeaders]) {
                    switch facilityViewModel.dataState{
                    case .initial:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                            .padding()
                    case .empty:
                        Text("No Facility Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding()
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
                                facilityViewModel.fetch()
                            } label: {
                                Text("Try Again")
                                    .font(.caption)
                                    .bold()
                            }
                        }
                    case .ok:
                        Section{
                            ForEach(facilityViewModel.facilities){ facility in
                                NavigationLink(destination: {
                                    FacilityView(facility: facility)
                                }){
                                    VStack(spacing: 0){
                                        FacilityListItemView(facility: facility)
                                            .padding()
                                        Divider()
                                    }
                                }
                            }
                        } header: {
                            VStack(spacing: 0) {
                                FacilitySortAndFilterBarView(selectedSortOptionKey: $facilityViewModel.sort)
                                    .padding(.bottom, 10)
                                Divider()
                            }
                        }
                        .background(Color(UIColor.systemBackground))
                    }
                }
            }
            .animation(.spring(), value: facilityViewModel.facilities)
            .navigationTitle("Recreation Facilities")
            .navigationBarTitleDisplayMode(.large)
        }
        .searchable(text: $facilityViewModelForSearch.searchTerm, placement: .navigationBarDrawer(displayMode: .automatic))
        .disableAutocorrection(true)
        .searchSuggestions({
            if !facilityViewModelForSearch.searchTerm.trim().isEmpty{
                FacilitySearchSuggestionsView(facilities: $facilityViewModelForSearch.facilities)
            }
        })
        .refreshable {
            facilityViewModel.fetch()
        }
    }
}

struct FacilitiesTabView_Previews: PreviewProvider {
    static var previews: some View {
        FacilitiesTabView()
    }
}
