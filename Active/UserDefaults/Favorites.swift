//
//  Favorites.swift
//  Active
//
//  Created by Emrah on 2022-12-08.
//

import Foundation

class Favorites: ObservableObject {
    @Published var facilities: Set<Facility> = []
    @Published var activityTypes: Set<ActivityType> = []
    @Published var facilityActivityTypes: Set<FacilityActivityType> = []
    let defaults = UserDefaults.standard

    init() {
        let decoder = PropertyListDecoder()
        
        if let data = defaults.value(forKey: "Favorite_Facilities") as? Data {
            let facilityData = try? decoder.decode(Set<Facility>.self, from: data)
            self.facilities = facilityData ?? []
        } else {
            self.facilities = []
        }
        
        if let data = defaults.value(forKey: "Favorite_ActivityTypes") as? Data {
            let activityTypeData = try? decoder.decode(Set<ActivityType>.self, from: data)
            self.activityTypes = activityTypeData ?? []
        } else {
            self.activityTypes = []
        }
        
        if let data = defaults.value(forKey: "Favorite_FacilityActivityTypes") as? Data {
            let facilityActivityTypeData = try? decoder.decode(Set<FacilityActivityType>.self, from: data)
            self.facilityActivityTypes = facilityActivityTypeData ?? []
        } else {
            self.facilityActivityTypes = []
        }
    }
    
    func refresh(){
        let decoder = PropertyListDecoder()
        
        if let data = defaults.value(forKey: "Favorite_Facilities") as? Data {
            let facilityData = try? decoder.decode(Set<Facility>.self, from: data)
            self.facilities = facilityData ?? []
        } else {
            self.facilities = []
        }
        
        if let data = defaults.value(forKey: "Favorite_ActivityTypes") as? Data {
            let activityTypeData = try? decoder.decode(Set<ActivityType>.self, from: data)
            self.activityTypes = activityTypeData ?? []
        } else {
            self.activityTypes = []
        }
        
        if let data = defaults.value(forKey: "Favorite_FacilityActivityTypes") as? Data {
            let facilityActivityTypeData = try? decoder.decode(Set<FacilityActivityType>.self, from: data)
            self.facilityActivityTypes = facilityActivityTypeData ?? []
        } else {
            self.facilityActivityTypes = []
        }
    }

    func containsActivityType(_ activityType:ActivityType)-> Bool{
        return activityTypes.contains(where: {$0.key.elementsEqual(activityType.key)})
    }
    
    func addActivityType(_ activityType: ActivityType) {
        activityTypes.insert(activityType)
        saveActivityType()
    }

    func removeActivityType(_ activityType: ActivityType) {
        let activityType = activityTypes.first(where: {$0.key.elementsEqual(activityType.key)})
        activityTypes.remove(activityType!)
        saveActivityType()
    }
    
    func containsFacility(_ facility:Facility)->Bool{
        return facilities.contains(where: {$0.key.elementsEqual(facility.key)})
    }
    
    func addFacility(_ facility: Facility) {
        facilities.insert(facility)
        saveFacility()
    }

    func removeFacility(_ facility: Facility) {
//        let facility = facilities.first(where: {$0.key.elementsEqual(facility.key)})
        facilities.remove(facility)
        saveFacility()
    }
    
    func containsFacilityActivityType(_ facilityActivityType:FacilityActivityType)-> Bool{
        return facilityActivityTypes.contains(facilityActivityType)
    }
    
    func addFacilityActivityType(_ facilityActivityType: FacilityActivityType) {
        facilityActivityTypes.insert(facilityActivityType)
        saveFacilityActivityType()
    }

    func removeFacilityActivityType(_ facilityActivityType: FacilityActivityType) {
        facilityActivityTypes.remove(facilityActivityType)
        saveFacilityActivityType()
    }

    func saveFacility() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.facilities) {
            self.defaults.set(encoded, forKey: "Favorite_Facilities")
        }
        defaults.synchronize()
    }
    
    func saveActivityType() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.activityTypes) {
            self.defaults.set(encoded, forKey: "Favorite_ActivityTypes")
        }
        defaults.synchronize()
    }
    
    func saveFacilityActivityType() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.facilityActivityTypes) {
            self.defaults.set(encoded, forKey: "Favorite_FacilityActivityTypes")
        }
        defaults.synchronize()
    }
}
