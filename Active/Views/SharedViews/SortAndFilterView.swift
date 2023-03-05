//
//  SortAndFilterView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-15.
//

import SwiftUI

struct SortAndFilterView: View {
    @Binding var searchCriteriaOptions:[SortAndFilterModel]
    @Binding var currentSelectionTitle:String
    @State var isSheetOpen:Bool=false
    @State var searchCriteriaTitle:String
    @Binding var isSelected:Bool
    @Binding var option:String
    @State var defaultOption:String
    @Binding var backgroundColor:Color
    @State var initialSelectionTitle:String
    var body: some View {
        HStack{
            Button {
                isSheetOpen.toggle()
            } label: {
                HStack {
                    Text(currentSelectionTitle)
                        .font(.caption)
                        .foregroundColor(isSelected ? .white : .gray)
                        .id(currentSelectionTitle)
                        .animation(Animation.linear(duration: 0.3).delay(0.3), value: currentSelectionTitle)
                    Image(systemName: "chevron.down")
                        .foregroundColor(isSelected ? .white  : .gray)
                        .font(.caption)
                        .animation(Animation.linear(duration: 0.3), value: currentSelectionTitle)
                }
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                .background(isSelected ? Color("OttawaColorAdjusted") : .clear)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke( isSelected ? Color("OttawaColorAdjusted") : .gray, lineWidth: 1)
                    )
            }
            .sheet(isPresented: $isSheetOpen){
                SortAndFilterSheetView(searchCriteriaOptions: $searchCriteriaOptions, searchCriteriaTitle: $searchCriteriaTitle, option: $option, currentSelectionTitle: $currentSelectionTitle, isSheetOpen: $isSheetOpen, isSelected: $isSelected, defaultOption: defaultOption, initialSelectionTitle: initialSelectionTitle)
                    .presentationDetents([.height(CGFloat((isSelected ? 130 : 90) + searchCriteriaOptions.count * 50))])
            }
            .transaction { hstackTransaction in
                hstackTransaction.animation = Animation.linear(duration: 0.3)
            }
        }.padding(.vertical, 1)
    }
}

struct SortAndFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterView(searchCriteriaOptions: .constant(SortOptions().facilitySortOptions), currentSelectionTitle: .constant(String()), isSheetOpen: Bool(), searchCriteriaTitle: String(), isSelected: .constant(Bool()), option: .constant(String()), defaultOption: String(), backgroundColor: .constant(Color.blue), initialSelectionTitle: String())
    }
}
