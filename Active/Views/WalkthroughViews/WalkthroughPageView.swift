//
//  WalkthroughPageView.swift
//  Active
//
//  Created by Emrah on 2023-01-30.
//

import SwiftUI

struct WalkthroughPageView: View {
    let page:WalkthroughPage
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Image(systemName: page.imageText)
                    .font(.title)
                    .foregroundStyle( Color.white, Color.ottawaColor)
                Text(page.titleText)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            HStack{
                Text(page.bodyText)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineSpacing(10)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Spacer()
        }
        .tag(page.id)
        .padding()
    }
}

struct WalkthroughPageView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughPageView(page: WalkthroughPage.pages.first!)
    }
}
