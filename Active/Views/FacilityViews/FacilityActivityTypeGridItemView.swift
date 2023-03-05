//
//  FacilityActivityTypeGridItemView.swift
//  Active
//
//  Created by Emrah on 2022-12-18.
//

import SwiftUI

struct FacilityActivityTypeGridItemView: View {
    let facility:Facility
    let category:Category
    let activityType:ActivityType
    let backgroundColor:Color
    var body: some View {
        NavigationLink(destination: {
            FacilityActivityTypeView(facility: facility, activityType: activityType)
            }){
                VStack{
                    HStack{
                        Text(activityType.title)
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .frame(height: 80)
                .background(Color.ottawaColorAdjusted)
                .cornerRadius(5)
            }
    }
}

struct FacilityActivityTypeItemView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityActivityTypeGridItemView(facility: Facility.sample(), category: Category.sample(), activityType: ActivityType.sample(), backgroundColor: Color.red)
    }
}
