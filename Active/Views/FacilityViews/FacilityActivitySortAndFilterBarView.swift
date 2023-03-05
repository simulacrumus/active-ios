//
//  FacilityActivitySortAndFilterBarView.swift
//  Active
//
//  Created by Emrah on 2023-01-15.
//

import SwiftUI

struct FacilityActivitySortAndFilterBarView: View {
    
    @Binding var isAvailable:String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                HStack{}.padding([.leading])
                AvailibilityFilterOptionView(isAvailable: $isAvailable)
                Spacer()
                HStack{}.padding([.leading], 10)
            }
        }
        .statusBarHidden(true)
    }
}

struct FacilityActivitySortAndFilterBarView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityActivitySortAndFilterBarView(isAvailable: .constant(String()))
    }
}
