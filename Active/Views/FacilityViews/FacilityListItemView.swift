//
//  FacilityListItemView.swift
//  Active
//
//  Created by Emrah on 2022-12-07.
//

import SwiftUI

struct FacilityListItemView: View {
    let facility:Facility
    let gradient = Gradient(colors: [Color("GrayBackgroundGradientStart"), Color("SystemBackgroundColor")])
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(facility.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("SecondaryTextColor"))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack{
                Text(facility.getAddress())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(facility.getDistance())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct FacilityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityListItemView(facility: Facility.sample())
    }
}
