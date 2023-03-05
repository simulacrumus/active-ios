//
//  ActivityTypeFavoritesView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-08.
//

import SwiftUI

struct ActivityTypeFavoritesView: View {
    @EnvironmentObject var favorites:Favorites
    var body: some View {
        VStack(spacing: 0){
            if favorites.activityTypes.isEmpty{
                Spacer()
                Text("No Favorite Activity")
                    .foregroundColor(.gray)
                    .font(.caption)
                Spacer()
            } else {
                ScrollView{
                    ForEach(favorites.activityTypes.sorted{$0.id < $1.id}){ favoriteActivityType in
                        NavigationLink(destination: {
                            ActivityTypeView(activityType: favoriteActivityType)
                        }){
                            FavoriteActivityTypeListItemView(favoriteActivityType: favoriteActivityType)
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

struct ActivityTypeFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTypeFavoritesView()
    }
}
