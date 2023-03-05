//
//  CategoryGridView.swift
//  Active
//
//  Created by Emrah on 2022-12-13.
//

import SwiftUI

struct CategoryGridView: View {
    let categories:[Category]
    
    var body: some View {
        Grid(alignment: .topLeading){
            ForEach(0..<((categories.count+1)/2), id: \.self) { index in
                GridRow{
                    HStack{
                        CategoryGridItemView(category: categories[(index * 2)], backgroundColor: Color.getColorForCategory(category: categories[index * 2].key))
                        Spacer()
                        if ((index * 2)+1)<categories.count{
                            CategoryGridItemView(category: categories[((index * 2) + 1)], backgroundColor: Color.getColorForCategory(category: categories[((index * 2) + 1)].key))
                        } else {
                            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                    }
                }
            }
        }
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView(categories: [Category]())
    }
}
