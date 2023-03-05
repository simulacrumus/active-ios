//
//  ActivityListItemView.swift
//  Active
//
//  Created by Emrah on 2023-01-06.
//

import SwiftUI

struct ActivityListItemView: View {
    let activity: Activity
    @State private var isSheetPresented:Bool = false
    var body: some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            VStack{
                HStack {
                    Text(activity.getShortTime())
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color("SecondaryTextColor"))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: activity.isAvailable ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.caption2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color("SecondaryWhite"), activity.isAvailable ? Color("Green") : Color("Red"))
                }.padding(.bottom,1)
                HStack{
                    Text(activity.title)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.bottom,1)
                HStack{
                    Text(activity.facility.title)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(activity.facility.getDistance())
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
            .cornerRadius(10)
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $isSheetPresented) {
            ActivityView(isSheetOpen: $isSheetPresented, activity: activity)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

struct ActivityListItem_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListItemView(activity:Activity.sample())
    }
}
