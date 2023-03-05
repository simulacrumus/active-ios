//
//  WalkthroughNavigation.swift
//  Active
//
//  Created by Emrah on 2023-01-30.
//

import SwiftUI

struct WalkthroughNavigation: View {
    @Binding var currentPage:Int
    var body: some View {
        HStack{
            if currentPage > 1{
                Button {
                    withAnimation(.easeInOut){
                        currentPage = currentPage - 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.primary)
                        .frame(width: 40, height: 40)
                        .background(Color(UIColor.systemGray5))
                        .clipShape(Circle())
                }
            }
            Spacer()
            Button {
                withAnimation(.easeInOut){
                    currentPage = currentPage + 1
                }
            } label: {
                Image(systemName: "chevron.right")
                    .bold()
                    .foregroundColor(currentPage < WalkthroughPage.pages.count ? .primary : .white)
                    .frame(width: 40, height: 40)
                    .background(currentPage < WalkthroughPage.pages.count ? Color(UIColor.systemGray5) : .ottawaColor)
                    .clipShape(Circle())
            }
        }
    }
}

struct WalkthroughNavigation_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughNavigation(currentPage: .constant(1))
    }
}
