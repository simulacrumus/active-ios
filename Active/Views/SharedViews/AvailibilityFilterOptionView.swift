//
//  AvailibilityFilterOptionView.swift
//  OttActivity
//
//  Created by Emrah on 2023-01-07.
//

import SwiftUI

struct AvailibilityFilterOptionView: View {
    @Binding var isAvailable:String
    
    var body: some View {
        HStack{
            Button {
                if isAvailable.isEmpty {
                    isAvailable = "true"
                } else {
                    isAvailable = ""
                }
            } label: {
                Text("Available")
                    .font(.caption)
                    .foregroundColor(isAvailable.isEmpty ? .gray : .white)
                    .id(isAvailable)
                    .animation(Animation.linear(duration: 0.3).delay(0.3), value: isAvailable)
                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                    .background(isAvailable.isEmpty ? .clear : Color.ottawaColorAdjusted)
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke( isAvailable.isEmpty ? .gray : Color.ottawaColorAdjusted, lineWidth: 1)
                        )
            }
            .transaction { transaction in
                transaction.animation = Animation.linear(duration: 0.3)
            }
        }
        .padding(.vertical,1)
    }
}

struct AvailibilityFilterOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AvailibilityFilterOptionView(isAvailable: .constant(String()))
    }
}
