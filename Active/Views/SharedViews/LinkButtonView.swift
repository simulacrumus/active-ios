//
//  LinkButtonView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-04.
//

import SwiftUI

struct LinkButtonView: View {
    @State var title:String
    @State var url:String
    var body: some View {
        Button{

        } label: {
            HStack{
                Spacer()
                Text(title.uppercased())
                    .foregroundColor(.white)
                    .bold()
                    .font(.subheadline)
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color.accentColor)
        }
    }
}

struct LinkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LinkButtonView(title: String(), url: String())
    }
}
