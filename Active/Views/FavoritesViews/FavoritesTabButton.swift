//
//  FavoritesTabButton.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-29.
//

import SwiftUI

struct FavoritesTabButton: View {
    @Binding var selectedTabTag:FavoriteTag
    let tag:FavoriteTag
    let title:String
    @Namespace var animation
    var body: some View {
        VStack(){
            Text(title)
                .foregroundColor(selectedTabTag == tag ? Color("OttawaColor") : .gray)
                .font(.headline)
                .bold()
                .padding(.bottom, 10)
            ZStack{
                if selectedTabTag == tag{
                    RoundedRectangle(cornerRadius: 4,style: .continuous)
                        .fill(Color.ottawaColor)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    RoundedRectangle(cornerRadius: 4,style: .continuous)
                        .fill(Color.clear)
                }
            }
            .frame(height: 4)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut){
                selectedTabTag = tag
            }
        }
    }
}

struct FavoritesTabButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTabButton(selectedTabTag: .constant(.facility), tag: .facility, title: String())
    }
}
