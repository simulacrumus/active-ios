//
//  CategoryGridItemView.swift
//  Active
//
//  Created by Emrah on 2022-12-13.
//

import SwiftUI

struct CategoryGridItemView: View {
    let category:Category
    let backgroundColor:Color
    var body: some View {
        NavigationLink(destination: {
            CategoryView(category: category, backgroundColor: backgroundColor)
                .navigationTitle(category.title)
                .navigationBarTitleDisplayMode(.large)
            }){
                VStack{
                    HStack{
                        Text(category.title)
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Image(systemName: Category.getCategoryImage(for: category.key))
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
                .frame(height: 80)
                .background(Color.ottawaColorAdjusted)
                .cornerRadius(5)
            }
    }
}

struct CategoryGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridItemView(category: Category.sample(),backgroundColor: Color.blue.opacity(0.2))
    }
}
