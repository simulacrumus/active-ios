//
//  FacilitySearchSuggestionsView.swift
//  Active
//
//  Created by Emrah on 2022-12-21.
//

import SwiftUI

struct FacilitySearchSuggestionsView: View {
    @Binding var facilities:[Facility]
    var body: some View {
        ForEach($facilities){ facility in
            ZStack{
                NavigationLink {
                    FacilityView(facility: facility.wrappedValue)
                } label: {
                    HStack{
                        Text(facility.title.wrappedValue)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct FacilitySearchSuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        FacilitySearchSuggestionsView(facilities: .constant([Facility]()))
    }
}
