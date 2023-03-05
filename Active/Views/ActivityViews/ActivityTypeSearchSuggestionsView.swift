//
//  ActivityTypeSearchSuggestionsView.swift
//  Active
//
//  Created by Emrah on 2022-12-20.
//

import SwiftUI

struct ActivityTypeSearchSuggestionsView: View {
    @Binding var activityTypes:[ActivityType]
    var body: some View {
        ForEach(activityTypes){ activityType in
            ZStack{
                NavigationLink {
                    ActivityTypeView(activityType: activityType)
                } label: {
                    HStack{
                        Text(activityType.title)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ActivityTypeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTypeSearchSuggestionsView(activityTypes: .constant([ActivityType.sample()]))
    }
}
