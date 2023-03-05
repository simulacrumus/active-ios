//
//  FavoriteActivityTypeListItemView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-04.
//

import SwiftUI

struct FavoriteActivityTypeListItemView: View {
    let favoriteActivityType:ActivityType
    var body: some View {
        HStack {
            Text(favoriteActivityType.title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

struct ActivityTypeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteActivityTypeListItemView(favoriteActivityType: ActivityType.sample())
    }
}
