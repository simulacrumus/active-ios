//
//  ScheduleTabView.swift
//  OttActivity
//
//  Created by Emrah on 2022-11-25.
//

import SwiftUI

struct ScheduleTabView: View {
    @EnvironmentObject var mySchedule:MySchedule
    
    var body: some View {
        NavigationStack{
            ScrollView() {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    if mySchedule.activities.isEmpty {
                        Text("No Saved Activities")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    if !mySchedule.activities.filter({ activity in
                        getDate(date: activity.activity.time) > Date()
                    }).isEmpty{
                        Section {
                            ForEach(mySchedule.activities.filter({ activity in
                                getDate(date: activity.activity.time) > Date()
                            }).sorted{Date.getDate(from: $0.activity.time) < Date.getDate(from: $1.activity.time)}) { activity in
                                Divider()
                                ScheduleListItemView(activity: activity.activity)
                            }
                        } header: {
                            HStack{
                                Text("Upcoming")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .bold()
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(UIColor.systemGray6))
                        }
                    }
                    if !mySchedule.activities.filter({ activity in
                        getDate(date: activity.activity.time) <= Date()
                    }).isEmpty{
                        Section {
                            ForEach(mySchedule.activities.filter({ activity in
                                getDate(date: activity.activity.time) <= Date()
                            }).sorted{Date.getDate(from: $0.activity.time) > Date.getDate(from: $1.activity.time)}) { activity in
                                Divider()
                                ScheduleListItemView(activity: activity.activity)
                            }
                        } header: {
                            HStack{
                                Text("Past")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .bold()
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(UIColor.systemGray6))
                        }
                    }
                }
            }
            .navigationTitle("My Schedule")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                mySchedule.refresh()
            }
        }
    }
}

struct ScheduleTabView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleTabView()
    }
}

private func getDate(date:String)->Date{
    let df: DateFormatter = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return df.date(from: date) ?? Date()
}
