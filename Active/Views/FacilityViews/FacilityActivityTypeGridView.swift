//
//  FacilityActivityTypeGridView.swift
//  Active
//
//  Created by Emrah on 2022-12-18.
//

import SwiftUI

struct FacilityActivityTypeGridView: View {
    let category:Category
    let backgroundColor:Color
    let facility:Facility
    var body: some View {
        Grid(alignment: .topLeading){
            ForEach(0..<((category.activityTypes.count+1)/2), id: \.self) { index in
                GridRow{
                    HStack{
                        FacilityActivityTypeGridItemView(facility: facility, category: category, activityType: category.activityTypes[(index * 2)], backgroundColor: backgroundColor)
                        Spacer()
                        if ((index * 2)+1)<category.activityTypes.count{
                            FacilityActivityTypeGridItemView(facility: facility, category: category, activityType: category.activityTypes[((index * 2) + 1)], backgroundColor: backgroundColor)
                        } else {
                            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                    }
                }
            }
        }
    }
}

struct FacilityActivityTypeGridView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityActivityTypeGridView(category: Category.sample(), backgroundColor: Color.red, facility: Facility.sample())
    }
}
