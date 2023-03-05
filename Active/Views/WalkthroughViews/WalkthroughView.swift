//
//  WalkthroughView.swift
//  Active
//
//  Created by Emrah on 2023-01-29.
//

import SwiftUI

struct WalkthroughView: View {
    
    @Binding var currentPage:Int
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                TabView(selection: $currentPage) {
                    ForEach(WalkthroughPage.pages){page in
                        WalkthroughPageView(page: page)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                .padding(.top, 40)
                .animation(.easeInOut, value: currentPage)
                WalkthroughNavigation(currentPage: $currentPage)
                    .padding(.horizontal)
            }
            .navigationTitle("Active")
        }
    }
}

struct WalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView(currentPage: .constant(1))
    }
}
