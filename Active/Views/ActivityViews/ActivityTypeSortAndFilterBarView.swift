//
//  ActivityTypeSortAndFilterBarView.swift
//  Active
//
//  Created by Emrah on 2022-12-15.
//

import SwiftUI

struct ActivityTypeSortAndFilterBarView: View {

    @Binding var facilities:[Facility]
    @Binding var selectedSortOptionKey:String
    @Binding var selectedFacilityOptionKey:String
    @Binding var isAvailable:String

    @State private var sortOptions = Option.activitySortOptions()
    @State private var facilityOptions = [Option.placeholderFacilityOption()]
    @State private var facilityIdCounter:Int = 0
    
    @State private var isOnlyAvailable:Bool = false
    
    let activityType:ActivityType
    private var selectedSortOption = Option.defaultActivityTypeSortOption()
    private var selectedFacilityOption = Option.placeholderFacilityOption()
    
    init( facilities: Binding<[Facility]>, selectedSortOptionKey: Binding<String>, selectedFacilityOptionKey: Binding<String>,isAvailable: Binding<String>, activityType:ActivityType) {
        self._selectedSortOptionKey = selectedSortOptionKey
        self._selectedFacilityOptionKey = selectedFacilityOptionKey
        self._facilities = facilities
        self._isAvailable = isAvailable
        self.activityType = activityType
        self.facilityOptions = [Option.placeholderFacilityOption()]
        self.facilityOptions.insert(contentsOf: facilities.map({ f in
                    facilityIdCounter += 1
            return Option(id: facilityIdCounter, key: f.wrappedValue.key, title: f.wrappedValue.title, subtitle: f.wrappedValue.title)
        }), at: 1)
        self.selectedSortOption = sortOptions.first(where: { option in
            option.key == selectedSortOptionKey.wrappedValue
        }) ?? Option.defaultActivityTypeSortOption()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                HStack{}.padding([.leading])
                SortOptionView(selectedOption: selectedSortOption, options: $sortOptions, selectedOptionKey: $selectedSortOptionKey)
                AvailibilityFilterOptionView(isAvailable: $isAvailable)
                FilterOptionView(
                    selectedOption: selectedFacilityOption,
                    options: {
                        var options = [Option.placeholderFacilityOption()]
                        options.append(contentsOf: facilities.map({ f in
                            Option(id: f.id, key:f.key, title: f.title, subtitle: f.title)
                        }))
                        return .constant(options)
                    }(),
                    selectedOptionKey: $selectedFacilityOptionKey
                )
                Spacer()
                HStack{}.padding([.leading], 10)
            }
        }
    }
}

struct ActivityTypeSortAndFilterBar_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTypeSortAndFilterBarView(facilities: .constant([Facility]()), selectedSortOptionKey: .constant(String()), selectedFacilityOptionKey: .constant(String()), isAvailable: .constant(String()), activityType: ActivityType.sample())
    }
}
