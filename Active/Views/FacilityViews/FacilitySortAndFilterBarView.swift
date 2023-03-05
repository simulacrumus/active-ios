//
//  FacilitySortAndFilterBarView.swift
//  Active
//
//  Created by Emrah on 2022-12-08.
//

import SwiftUI

struct FacilitySortAndFilterBarView: View {
    @Binding var selectedSortOptionKey:String
    private let selectedSortOption = Option.defaultFacilitySortOption()
    private let sortOptions = Option.facilitySortOptions()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                HStack{}.padding([.leading])
                SortOptionView(selectedOption: selectedSortOption, options: .constant(sortOptions), selectedOptionKey: $selectedSortOptionKey)
                    .presentationDetents([.fraction(0.25)])
                Spacer()
                HStack{}.padding([.leading], 10)
            }
        }
        .statusBarHidden(true)
    }
}

struct FacilitySearchOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        FacilitySortAndFilterBarView(selectedSortOptionKey: .constant(String()))
    }
}
