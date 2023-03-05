//
//  FavoriteFacilityListItemView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-25.
//

import SwiftUI

struct FavoriteFacilityListItemView: View {
    let facility:Facility
    var body: some View {
        HStack {
            Text(facility.title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

struct FavoriteFacilityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteFacilityListItemView(facility: Facility.sample())
    }
}
