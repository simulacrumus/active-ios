//
//  ActivityTypeGridItemView.swift
//  Active
//
//  Created by Emrah on 2022-12-14.
//

import SwiftUI

struct ActivityTypeGridItemView: View {
    let activityType:ActivityType
    let backgroundColor:Color
    var body: some View {
        NavigationLink(destination: {
                ActivityTypeView(activityType: activityType)
            }){
                VStack{
                    HStack{
                        Text(activityType.title)
                            .foregroundColor(.white)
                            .font(.body)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
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

struct ActivityTypeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTypeGridItemView(activityType: ActivityType.sample(), backgroundColor: Color.blue)
    }
}
