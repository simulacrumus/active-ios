//
//  SortAndFilterOptionsSheetView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-26.
//

import SwiftUI

struct SortAndFilterOptionsSheetView: View {

    @Binding var isSheetOpen:Bool
    @Binding var selectedOption:Option
    @Binding var options:[Option]
    @Binding var selectedOptionKey:String
    @State private var sheetHeight: CGFloat = .zero

    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 0){
                Text(options[0].subtitle)
                    .font(.title3)
                    .bold()
                Spacer()
                Button{
                    isSheetOpen=false
                }label:{
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.gray, Color(UIColor.systemGray5))
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 2))
            ScrollView(.vertical, showsIndicators: true){
                LazyVStack(spacing: .zero){
                    ForEach(options.filter({ option in
                        option.id != 0 && option.id != -1
                    })) { option in
                        Button(action: {
                            isSheetOpen=false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                selectedOption = option
                                selectedOptionKey = option.key
                            }
                        }, label: {
                            HStack{
                                Text(option.subtitle)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Image(systemName: option.id == selectedOption.id ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(option.id == selectedOption.id ? .accentColor : .primary)
                                    .font(.title3)
                            }
                        })
                        .padding(10)
                        .foregroundColor(.primary)
                    }
                }
            }
            .scrollIndicators(.visible)
            if selectedOption.id != 0 && options[0].id == 0{
                Button{
                    isSheetOpen=false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        selectedOption = options[0]
                        selectedOptionKey = options[0].key
                    }
                } label: {
                    HStack{
                        Spacer()
                        Text("Clear Selection")
                            .foregroundColor(.white)
                            .bold()
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.red)
                    .cornerRadius(5)
                }
                .padding(10)
            }
        }
        .presentationDragIndicator(.automatic)
        .padding()
    }
}

struct SortAndFilterOptionsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SortAndFilterOptionsSheetView(isSheetOpen: .constant(false), selectedOption: .constant(Option(id: 0, key: String(), title: String(), subtitle: String())), options: .constant([Option]()), selectedOptionKey: .constant(String()))
    }
}
