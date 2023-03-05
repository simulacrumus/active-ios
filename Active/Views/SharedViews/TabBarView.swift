//
//  TabBarView.swift
//  OttActivity
//
//  Created by Emrah on 2022-11-25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView() {
            ActivitiesTabView()
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("Activities")
                }
            FacilitiesTabView()
                .tabItem {
                    Image(systemName: "building.2")
                    Text("Facilities")
                }
            FavoritesTabView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                    
                }
            ScheduleTabView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("My Schedule")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
