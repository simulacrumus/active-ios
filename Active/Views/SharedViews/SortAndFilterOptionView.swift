//
//  SortAndFilterOptionView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-26.
//

import SwiftUI

struct SortAndFilterOptionView: View {
    
    @State var isSheetOpen:Bool=false
    @State var selectedOption:Option
    @Binding var options:[Option]
    @Binding var selectedOptionKey:String
    
    var body: some View {
        HStack{
            Button {
                isSheetOpen.toggle()
            } label: {
                HStack {
                    Text(selectedOption.title)
                        .font(.caption)
                        .foregroundColor(selectedOption.id != 0 ? .white : .gray)
                        .id(selectedOptionKey)
                        .animation(Animation.linear(duration: 0.3).delay(0.3), value: selectedOptionKey)
                    Image(systemName: "chevron.down")
                        .foregroundColor(selectedOption.id != 0 ? .white  : .gray)
                        .font(.caption)
                        .animation(Animation.linear(duration: 0.3), value: selectedOptionKey)
                }
                .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                .background(selectedOption.id != 0 ? Color.ottawaColorAdjusted : .clear)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke( selectedOption.id != 0 ? Color.ottawaColorAdjusted : .gray, lineWidth: 1)
                    )
            }
            .sheet(isPresented: $isSheetOpen){
                SortAndFilterOptionsSheetView(isSheetOpen: $isSheetOpen, selectedOption: $selectedOption, options: $options, selectedOptionKey: $selectedOptionKey)
            }
            .transaction { transaction in
                transaction.animation = Animation.linear(duration: 0.3)
            }
        }.padding(.vertical, 1)
    }
}

struct SortAndFilterOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterOptionView(selectedOption: Option(id: 0, key: String(), title: String(), subtitle: String()), options: .constant([Option]()), selectedOptionKey: .constant(String()))
    }
}
