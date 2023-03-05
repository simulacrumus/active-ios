//
//  FacilityCategoryView.swift
//  Active
//
//  Created by Emrah on 2022-12-17.
//

import SwiftUI

struct FacilityCategoryView: View {
    let category:Category
    let backgroundColor:Color
    let facility:Facility
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text(category.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                FacilityActivityTypeGridView(category: category, backgroundColor: backgroundColor, facility: facility)
                Spacer()
            }
            .navigationBarTitle(facility.title)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct FacilityCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityCategoryView(category: Category.sample(), backgroundColor: Color.blue, facility:Facility.sample())
    }
}
