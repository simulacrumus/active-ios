//
//  ActivityTypeView.swift
//  Active
//
//  Created by Emrah on 2022-12-15.
//

import SwiftUI

struct ActivityTypeView: View {
    @EnvironmentObject var favorites:Favorites
    @StateObject var activityViewModel:ActivityViewModel
    @StateObject var facilityViewModel:FacilityViewModel
    @State var isSheetOpen:Bool = false
    
    let activityType:ActivityType

    init(activityType: ActivityType){
        self.activityType=activityType
        self._activityViewModel = StateObject(wrappedValue: ActivityViewModel(activityType: activityType.key))
        self._facilityViewModel = StateObject(wrappedValue: FacilityViewModel(activityType: activityType.key))
    }
    
    var body: some View {
        ScrollViewReader{ proxy in
            ScrollView{
                LazyVStack(spacing:0, pinnedViews:[.sectionHeaders]) {
                    Section {
                        switch activityViewModel.dataState{
                        case .initial:
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(maxWidth: .infinity)
                                .padding()
                        case .empty:
                            Text("No More Available Times")
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
                                    activityViewModel.fetch()
                                    facilityViewModel.fetch()
                                } label: {
                                    Text("Try Again")
                                        .font(.caption)
                                        .bold()
                                }
                            }
                            .padding()
                        case .ok:
                            ForEach($activityViewModel.activities){ activity in
                                ActivityListItemView(activity: activity.wrappedValue)
                                Divider()
                            }
                            switch activityViewModel.fetchState {
                            case .idle:
                                Color.clear
                                    .padding()
                                    .onAppear {
                                        activityViewModel.fetchNextPage()
                                    }
                            case .loading:
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            case .loadedAll:
                                EmptyView()
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
                                        activityViewModel.fetch()
                                        facilityViewModel.fetch()
                                    } label: {
                                        Text("Try Again")
                                            .foregroundColor(Color.ottawaColor)
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                            }
                        }
                    } header: {
                        VStack(spacing: 0){
                            ActivityTypeSortAndFilterBarView(facilities: $facilityViewModel.facilities, selectedSortOptionKey: $activityViewModel.sort, selectedFacilityOptionKey: $activityViewModel.facility, isAvailable: $activityViewModel.available, activityType: activityType)
                                .padding(.bottom,10)
                            Divider()
                        }
                        .background(Color(UIColor.systemBackground))
                    }
                }.animation(.spring(), value: activityViewModel.activities)
            }
        }
        .navigationTitle(activityType.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            ToolbarItem (placement: .navigationBarTrailing, content: {
                Button{
                    if favorites.containsActivityType(activityType){
                        favorites.removeActivityType(activityType)
                    } else {
                        favorites.addActivityType(activityType)
                    }
                    isSheetOpen = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        isSheetOpen = false
                    }
                }label: {
                    HStack{
                        Image(systemName: favorites.containsActivityType(activityType) ? "star.fill" : "star")
                            .font(.caption)
                            .foregroundColor(Color.accentColor)
                    }.padding(.vertical).padding(.leading)
                }
            })
        }
        .sheet(isPresented: $isSheetOpen){
            FavoritesSnackBarView(message: "\(activityType.title) \( favorites.containsActivityType(activityType) ? "Added to" : "Removed from") Favorite Activities")
        }
        .refreshable {
            activityViewModel.fetch()
            facilityViewModel.fetch()
        }
    }
}

struct ActivityTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTypeView(activityType: ActivityType.sample())
    }
}
