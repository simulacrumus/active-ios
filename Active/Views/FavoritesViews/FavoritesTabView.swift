//
//  FavoritesTabView.swift
//  OttActivity
//
//  Created by Emrah on 2022-11-25.
//


import SwiftUI

struct FavoritesTabView: View {
    @State var selectedTabTag:FavoriteTag = .facility
    @Namespace var animation

    var body: some View {
        NavigationStack{
            VStack(){
                VStack(alignment: .trailing, spacing: 0){
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack(){
                            VStack(){
                                Text("Facility")
                                    .foregroundColor(selectedTabTag == .facility ? Color("OttawaColor") : .gray)
                                    .font(.headline)
                                    .bold()
                                    .padding(.bottom, 10)
                                ZStack{
                                    if selectedTabTag == .facility{
                                        RoundedRectangle(cornerRadius: 4,style: .continuous)
                                            .fill(Color.ottawaColor)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                    } else {
                                        RoundedRectangle(cornerRadius: 4,style: .continuous)
                                            .fill(Color.clear)
                                    }
                                }
                                .frame(height: 4)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    selectedTabTag = .facility
                                }
                            }
                            .padding([.leading])
                            .animation(.easeOut(duration: 0.2), value: selectedTabTag)
                            VStack(){
                                Text("Activity")
                                    .foregroundColor(selectedTabTag == .activityType ? Color("OttawaColor") : .gray)
                                    .font(.headline)
                                    .bold()
                                    .padding(.bottom, 10)
                                ZStack{
                                    if selectedTabTag == .activityType{
                                        RoundedRectangle(cornerRadius: 4,style: .continuous)
                                            .fill(Color.ottawaColor)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                    } else {
                                        RoundedRectangle(cornerRadius: 4,style: .continuous)
                                            .fill(Color.clear)
                                    }
                                }
                                .frame(height: 4)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    selectedTabTag = .activityType
                                }
                            }
                            .padding([.leading])
                            .animation(.easeOut(duration: 0.3), value: selectedTabTag)
                        }
                    }
                    .padding(.top)
                    Divider()
                }
                TabView(selection: $selectedTabTag){
                    FacilityFavoritesView()
                        .tag(FavoriteTag.facility)
                    ActivityTypeFavoritesView()
                        .tag(FavoriteTag.activityType)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FavoritesTabView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTabView()
    }
}
