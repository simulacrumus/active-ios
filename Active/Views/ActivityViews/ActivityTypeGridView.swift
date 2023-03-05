//
//  ActivityTypeGridView.swift
//  Active
//
//  Created by Emrah on 2022-12-14.
//

import SwiftUI

struct ActivityTypeGridView: View {
    let category:Category
    let backgroundColor:Color
    var body: some View {
        Grid(alignment: .topLeading){
            ForEach(0..<((category.activityTypes.count+1)/2), id: \.self) { index in
                GridRow{
                    HStack{
                        ActivityTypeGridItemView(activityType: category.activityTypes[(index * 2)], backgroundColor: backgroundColor)
                        Spacer()
                        if ((index * 2)+1)<category.activityTypes.count{
                            ActivityTypeGridItemView(activityType: category.activityTypes[((index * 2) + 1)], backgroundColor: backgroundColor)
                        } else {
                            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                    }
                }
            }
        }
    }
}

struct ActivityTypeGridView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTypeGridView(category: Category.sample(), backgroundColor: Color.red)
    }
}
