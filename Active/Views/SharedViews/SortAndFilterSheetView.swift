//
//  SortAndFilterSheetView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-15.
//

import SwiftUI

struct SortAndFilterSheetView: View {
    @Binding var searchCriteriaOptions:[SortAndFilterModel]
    @Binding var searchCriteriaTitle:String
    @Binding var option:String
    @Binding var currentSelectionTitle:String
    @Binding var isSheetOpen:Bool
    @Binding var isSelected:Bool
    @State var defaultOption:String
    @State var initialSelectionTitle:String
    var body: some View {
        VStack{
            HStack{
                Text(searchCriteriaTitle)
                    .font(.title3)
                    .bold()
                Spacer()
                Button{
                    isSheetOpen=false
                }label:{
                    Image(systemName: "xmark").foregroundColor(.primary)
                }
            }
            .padding(10)
            ScrollView{
                ForEach(searchCriteriaOptions) { searchCriteriaOption in
                    Button{
                        isSheetOpen=false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isSelected=true
                            currentSelectionTitle=searchCriteriaOption.title
                            option=searchCriteriaOption.option
                        }
                    } label: {
                        Text(searchCriteriaOption.subtitle)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Image(systemName: option == searchCriteriaOption.option ? "record.circle" : "circle")
                            .foregroundColor(.accentColor)
                    }
                    .padding([.horizontal,.vertical], 10)
                    .foregroundColor(.primary)
                }
            }
            if isSelected {
                Button{
                    isSheetOpen=false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isSelected=false
                        option=defaultOption
                        currentSelectionTitle=initialSelectionTitle
                    }
                } label: {
                    HStack{
                        Spacer()
                        Text("Reset")
                            .foregroundColor(.white)
                            .bold()
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.pink)
                }
                .padding(.vertical)
                .padding(.horizontal, 10)
                .cornerRadius(5)
            }
        }
        .presentationDragIndicator(.automatic)
        .padding()
    }
}

struct SortAndFilterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterSheetView(searchCriteriaOptions: .constant(SortOptions().facilitySortOptions), searchCriteriaTitle: .constant("Sort By"), option: .constant("id") , currentSelectionTitle: .constant("Facility"), isSheetOpen: .constant(false), isSelected: .constant(false), defaultOption: "id", initialSelectionTitle: "All Facilities")
    }
}
