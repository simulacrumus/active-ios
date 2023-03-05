//
//  CategoryView.swift
//  Active
//
//  Created by Emrah on 2022-12-13.
//

import SwiftUI

struct CategoryView: View {
    let category:Category
    let backgroundColor:Color
    var body: some View {
        ScrollView(showsIndicators: false){
            ActivityTypeGridView(category: category, backgroundColor: backgroundColor)
                .padding(.top)
        }
        .padding(.horizontal)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category.sample(), backgroundColor: Color.blue)
    }
}
