//
//  ScheduleListItemView.swift
//  OttActivity
//
//  Created by Emrah on 2023-01-21.
//

import SwiftUI

struct ScheduleListItemView: View {
    let activity: Activity
    @State private var isSheetPresented:Bool = false
    var body: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            VStack{
                HStack {
                    Text(activity.title)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.bottom,1)
                HStack{
                    Text(activity.getRegularTime())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.bottom,1)
                HStack{
                    Text(activity.facility.title)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .padding()
        }
        .sheet(isPresented: $isSheetPresented) {
            ScheduleActivityView(isSheetOpen: $isSheetPresented, activity: activity)
        }
    }
}

struct MyActivityListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListItemView(activity:Activity.sample())
    }
}
