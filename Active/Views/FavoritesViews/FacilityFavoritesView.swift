//
//  FacilityFavoritesView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-08.
//

import SwiftUI

struct FacilityFavoritesView: View {
    @EnvironmentObject var favorites:Favorites
    var body: some View {
        VStack(spacing: 0){
            if favorites.facilities.isEmpty{
                Spacer()
                Text("No Favorite Facility")
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer()
            } else {
                ScrollView{
                    ForEach(favorites.facilities.sorted{$0.id < $1.id}){ facility in
                        NavigationLink(destination: {
                            FacilityView(facility: facility)
                        }){
                            FavoriteFacilityListItemView(facility: facility)
                                .padding()
                        }
                        Divider()
                    }
                }
            }
        }
        .task {
            favorites.refresh()
        }
    }
}

struct FacilityFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityFavoritesView()
    }
}
