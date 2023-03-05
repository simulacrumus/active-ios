//
//  ScheduleActivityView.swift
//  OttActivity
//
//  Created by Emrah on 2023-01-21.
//

import SwiftUI
import MapKit

struct ScheduleActivityView: View {
    @EnvironmentObject var mySchedule:MySchedule
    @Binding var isSheetOpen:Bool
    @State var ETA:String = ""
    let activity:Activity

    var body: some View {
        VStack(alignment: .leading){
            VStack{
                Group {
                    HStack{
                        Text("\(activity.category) • \(activity.type)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Button {
                            isSheetOpen = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30))
                                .foregroundStyle(.gray, Color(UIColor.systemGray5))
                        }

                    }
                    .padding(.top)
                    .padding(.bottom, 10)
                    HStack{
                        Text(activity.title)
                            .font(.title)
                            .foregroundColor(Color("SecondaryTextColor"))
                            .multilineTextAlignment(.leading)
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    HStack{
                        Image(systemName: "clock")
                            .font(.body)
                            .foregroundColor(Color("SecondaryTextColor"))
                        Text(activity.getRegularTime())
                            .font(.body)
                            .foregroundColor(Color("SecondaryTextColor"))
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    HStack{
                        Image(systemName: "building.2")
                            .font(.body)
                            .foregroundColor(Color("SecondaryTextColor"))
                        Text(activity.facility.title)
                            .font(.body)
                            .foregroundColor(Color("SecondaryTextColor"))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                }
                Button{
                    openFacilityInMaps(facility: activity.facility)
                }label: {
                    VStack {
                        HStack{
                            Text(activity.facility.getAddress())
                                .font(.subheadline)
                                .foregroundColor(Color.accentColor)
                            Spacer()
                            Image(systemName: ETA.isEmpty ? "" : "car.fill")
                                .font(.subheadline)
                                .foregroundColor(Color.accentColor)
                            Text(ETA)
                                .font(.subheadline)
                                .foregroundColor(Color.accentColor)
                        }
                        MapDirectionView(destinationLocation: Location(lat: activity.facility.lat, lng: activity.facility.lng, title: activity.facility.title), ETA: $ETA)
                            .cornerRadius(10)
                            .frame(height: 200)
                    }
                }
                HStack{
                    Link(destination: URL(string: activity.reservationURL)!){
                        Text("Reserve a Spot")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.accentColor)
                    }
                    Spacer()
                    Button {
                        if mySchedule.containsActivity(MyScheduleActivity(id: activity.title.appending(activity.facility.key).appending(activity.time), activity: activity)){
                            mySchedule.removeActivity(MyScheduleActivity(id: activity.title.appending(activity.facility.key).appending(activity.time), activity: activity))
                        } else {
                            mySchedule.addActivity(MyScheduleActivity(id: activity.title.appending(activity.facility.key).appending(activity.time), activity: activity))
                        }
                    } label: {
                        Text(mySchedule.containsActivity(MyScheduleActivity(id: activity.title.appending(activity.facility.key).appending(activity.time), activity: activity)) ? "Remove from My Activities" : "Add to My Activities")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.accentColor)
                    }
                }
                .padding(.vertical)
            }
            Spacer()
        }
        .padding()
        .presentationDragIndicator(.visible)
        .presentationDetents([.fraction(0.75)])
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

struct MyActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleActivityView(isSheetOpen: .constant(false), activity: Activity.sample())
    }
}
