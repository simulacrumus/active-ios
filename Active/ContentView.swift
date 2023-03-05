//
//  ContentView.swift
//  Active
//
//  Created by Emrah on 2022-11-24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var favorites:Favorites = Favorites()
    @StateObject var mySchedule:MySchedule = MySchedule()
    @AppStorage("Walkthrough_Current_Page") private var currentPage = 1
    
    init() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    var body: some View {
        if currentPage <= WalkthroughPage.pages.count{
            WalkthroughView(currentPage: $currentPage)
        } else {
            TabBarView()
                .environmentObject(self.favorites)
                .environmentObject(self.mySchedule)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .colorScheme(.dark)
    }
}
