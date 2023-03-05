//
//  MySchedule.swift
//  Active
//
//  Created by Emrah on 2023-01-13.
//

import Foundation

class MySchedule: ObservableObject {
    @Published var activities: Set<MyScheduleActivity> = []

    let defaults = UserDefaults.standard

    init() {
        let decoder = PropertyListDecoder()
        
        if let data = defaults.value(forKey: "MySchedule_Activities") as? Data {
            let activityData = try? decoder.decode(Set<MyScheduleActivity>.self, from: data)
            self.activities = activityData ?? []
        } else {
            self.activities = []
        }
    }
    
    func refresh(){
        let decoder = PropertyListDecoder()
        
        if let data = defaults.value(forKey: "MySchedule_Activities") as? Data {
            let activityData = try? decoder.decode(Set<MyScheduleActivity>.self, from: data)
            self.activities = activityData ?? []
        } else {
            self.activities = []
        }
    }

    func containsActivity(_ myScheduleActivity:MyScheduleActivity)-> Bool{
        return activities.contains(myScheduleActivity)
    }
    
    func addActivity(_ myScheduleActivity:MyScheduleActivity) {
        activities.insert(myScheduleActivity)
        saveActivity()
    }

    func removeActivity(_ myScheduleActivity:MyScheduleActivity) {
        activities.remove(myScheduleActivity)
        saveActivity()
    }
    
    func saveActivity() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.activities) {
            self.defaults.set(encoded, forKey: "MySchedule_Activities")
        }
        defaults.synchronize()
    }
}
