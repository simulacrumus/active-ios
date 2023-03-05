//
//  FacilityCategoryListView.swift
//  Active
//
//  Created by Emrah on 2022-12-17.
//

import SwiftUI

struct FacilityCategoryListView: View {
    let facility:Facility
    @StateObject var categoryViewModel:CategoryViewModel
    
    init(facility: Facility) {
        self.facility = facility
        self._categoryViewModel = StateObject(wrappedValue: CategoryViewModel(facility: facility.key))
    }
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        switch categoryViewModel.fetchState{
                        case .idle, .loadedAll:
                            ForEach(categoryViewModel.categories){ category in
                                Section {
                                    FacilityActivityTypeGridView(category: category, backgroundColor: Color.getColorForCategory(category: category.key), facility: facility)
                                } header: {
                                    HStack{
                                        Text(category.title)
                                            .font(.title3)
                                            .bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .background(Color(UIColor.systemBackground))
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            }
                        case .loading:
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(maxWidth: .infinity)
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
                                } label: {
                                    Text("Try Again")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                    } header: {
                        VStack(spacing: 0, content: {
                            HStack{
                                Text(facility.title)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom,10)
                            Divider()
                        })
                        .background(Color(UIColor.systemBackground))
                    }
                }
            }
        }
        .navigationBarTitle("Activities")
        .navigationBarTitleDisplayMode(.large)
        .refreshable {
            categoryViewModel.fetch()
        }
    }
}

struct FacilityCategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityCategoryListView(facility:Facility.sample())
    }
}
