//
//  FacilityView.swift
//  Active
//
//  Created by Emrah on 2022-12-07.
//

import SwiftUI
import MapKit

struct FacilityView: View {
    @EnvironmentObject var favorites:Favorites
    @State var isSheetOpen:Bool = false
    @State var ETA:String = ""
    
    let facility:Facility
    
    var body: some View {
        ScrollView(showsIndicators: false){
            HStack{
                Text(facility.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.vertical)
            VStack{
                HStack{
                    Text("Contact")
                        .foregroundColor(Color.secondaryText)
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                HStack{
                    Link( destination: URL(string: "mailto:\(facility.email)")!){
                        Image(systemName: "envelope")
                            .font(.subheadline)
                            .foregroundColor(Color.accentColor)
                        Text(facility.email)
                            .font(.subheadline)
                            .foregroundColor(Color.accentColor)
                    }
                    Spacer()
                }.padding(.vertical, 1)
                HStack{
                    Link( destination: URL(string: "tel:\(facility.phone)")!){
                        Image(systemName: "phone")
                            .font(.subheadline)
                            .foregroundColor(Color.accentColor)
                        Text(facility.phone)
                            .font(.subheadline)
                            .foregroundColor(Color.accentColor)
                    }
                    Spacer()
                }.padding(.vertical, 1)
                HStack{
                    Link(destination: URL(string: facility.url)!){
                        Image(systemName: "globe")
                            .font(.subheadline)
                            .foregroundColor(Color.accentColor)
                        Text("ottawa.ca")
                            .font(.subheadline)
                            .foregroundColor(Color.accentColor)
                    }
                    Spacer()
                }.padding(.vertical, 1)
            }
            .padding(.bottom)
            VStack{
                HStack{
                    Text("Address")
                        .font(.title3)
                        .foregroundColor(Color.secondaryText)
                        .bold()
                    Spacer()
                }
                Button {
                    openFacilityInMaps(facility: facility)
                } label: {
                    VStack{
                        HStack{
                            Image(systemName: "mappin")
                                .font(.caption)
                                .foregroundColor(Color.accentColor)
                            Text(facility.getAddress())
                                .font(.subheadline)
                                .foregroundColor(Color.accentColor)
                            Spacer()
                            Image(systemName: ETA.isEmpty ? "" : "car.fill")
                                .font(.caption)
                                .foregroundColor(Color.accentColor)
                            Text(ETA)
                                .font(.subheadline)
                                .foregroundColor(Color.accentColor)
                        }.padding(.vertical, 1)
                        MapDirectionView(destinationLocation: Location(lat: facility.lat, lng: facility.lng, title: facility.title),ETA: $ETA)
                        .cornerRadius(5)
                        .frame(height: 200)
                    }
                }
            }
            .padding(.bottom)
            NavigationLink {
                FacilityCategoryListView(facility: facility)
            } label: {
                HStack{
                    Text("Browse Activities at \(facility.title)")
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.accentColor)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(Color.accentColor)
                }
            }
            .padding(.bottom)
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem (placement: .navigationBarTrailing, content: {
                Button{
                    if favorites.containsFacility(facility){
                        favorites.removeFacility(facility)
                    } else {
                        favorites.addFacility(facility)
                    }
                    isSheetOpen = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isSheetOpen = false
                    }
                    }label: {
                        HStack{
                            Image(systemName: favorites.containsFacility(facility) ? "star.fill" : "star")
                                .font(.caption)
                                .foregroundColor(Color.accentColor)
                        }
                        .padding(.vertical)
                        .padding(.leading)
                    }
            })
        }
        .padding(.horizontal)
        .sheet(isPresented: $isSheetOpen){
            FavoritesSnackBarView(message: "\(facility.title) \( favorites.containsFacility(facility) ? "Added to" : "Removed from") Favorite Facilities")
        }
    }
}

private func openFacilityInMaps(facility:Facility){
    let regionDistance:CLLocationDistance = 500
    let coordinates = CLLocationCoordinate2DMake(facility.lat, facility.lng)
    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    let options = [
        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = facility.title
    mapItem.openInMaps(launchOptions: options)
}

struct FacilityView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityView(facility:Facility.sample())
    }
}
