//
//  PopularActivityGridView.swift
//  Active
//
//  Created by Emrah on 2023-01-05.
//

import SwiftUI

struct PopularActivityGridView: View {
    
    let activityTypes:[ActivityType]
    
    var body: some View {
        Grid(alignment: .topLeading){
            ForEach(0..<((activityTypes.count+1)/2), id: \.self) { index in
                GridRow{
                    HStack{
                        ActivityTypeGridItemView(activityType: activityTypes[(index * 2)], backgroundColor: Color.getColorForCategory(category: activityTypes[index * 2].category.lowercased()))
                        Spacer()
                        if ((index * 2)+1)<activityTypes.count{
                            ActivityTypeGridItemView(activityType: activityTypes[((index * 2) + 1)], backgroundColor: Color.getColorForCategory(category: activityTypes[((index * 2) + 1)].category.lowercased()))
                        } else {
                            Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                    }
                }
            }
        }
    }
}

struct PopularActivityGridView_Previews: PreviewProvider {
    static var previews: some View {
        PopularActivityGridView(activityTypes: [ActivityType]())
    }
}
