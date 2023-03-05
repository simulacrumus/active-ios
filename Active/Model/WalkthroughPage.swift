//
//  WalkthroughPage.swift
//  Active
//
//  Created by Emrah on 2023-01-30.
//

import Foundation

struct WalkthroughPage:Identifiable{
    var id:Int
    var imageText:String
    var titleText:String
    var bodyText:String
    
    static var pages:[WalkthroughPage] = [
        WalkthroughPage(
            id: 1,
            imageText: "figure.run.circle.fill",
            titleText: "Welcome to Active!",
            bodyText: "All Drop-in Activities for Ottawa Recreation Facilities, in one place"
        ),
        WalkthroughPage(
            id: 2,
            imageText: "info.circle.fill",
            titleText: "Disclaimer",
            bodyText: "Active is an open source third party search application, for drop-in activities at City of Ottawa Recreation Facilities. Data is collected from City of Ottawa official website and might not always be accurate"
        ),
        WalkthroughPage(
            id: 3,
            imageText: "star.circle.fill",
            titleText: "Features",
            bodyText: "-Search for a drop-in activity or a facility with advanced search options\n-Sort activities by distance, relevant to your current location, or activity time\n-Filter activities by availability\nFilter activities for a specific facility\n-Sort facilities by distance, relevant to your current location\n-Save your favourite activities or facilities for a quick access\n-Save your activities to your schedule and do not miss any activity and see your activity history"
        ),
        WalkthroughPage(
            id: 4,
            imageText: "location.circle.fill",
            titleText: "Location",
            bodyText: "Active does not collect any personal data, but location data is required to sort activities and facilities by distance. Please allow location access for a better experience"
        ),
        WalkthroughPage(
            id: 5,
            imageText: "hand.thumbsup.circle.fill",
            titleText: "Review",
            bodyText: "Thanks for using Active! Please share your feedback on AppStore, it is important to make this app better\n\nEmrah Kinay"
        )
    ]
}
