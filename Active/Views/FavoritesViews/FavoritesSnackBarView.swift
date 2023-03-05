//
//  FavoritesSnackBarView.swift
//  OttActivity
//
//  Created by Emrah on 2023-01-02.
//

import SwiftUI

struct FavoritesSnackBarView: View {
    let message:String
    var body: some View {
        ZStack{
            Color("systemBackground")
                .edgesIgnoringSafeArea(.all)
            Text(message)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
        }
        .presentationDetents([.fraction(0.1)])
    }
}

struct FavoritesSnackBarView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSnackBarView(message: String())
    }
}
