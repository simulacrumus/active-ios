//
//  Extensions.swift
//  Active
//
//  Created by Emrah on 2023-01-11.
//

import SwiftUI

extension Color{
    static let ottawaColor =  Color("OttawaColor")
    static let ottawaColorAdjusted = Color("OttawaColorAdjusted")
    static let secondaryText = Color("SecondaryTextColor")
    
    static func getColorForCategory(category:String)-> Color{
        return Color(category)
    }
    
    static func getColorForActivityType(activityType:String)-> Color{
        return Color(activityType)
    }
}

extension UINavigationController{
    
    open override func viewDidLoad() {
        @Environment(\.colorScheme) var colorScheme
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        navigationBar.largeTitleTextAttributes = [.foregroundColor: Color.secondaryText]
        navigationBar.titleTextAttributes = [.foregroundColor: Color.secondaryText]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}

extension Date {
    func dayNameOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    static func getDate(from date:String) -> Date{
        let df:DateFormatter = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return df.date(from: date) ?? Date()
    }
    
    func getRelativeDateTime() -> String{
        let rdtf = RelativeDateTimeFormatter()
        rdtf.dateTimeStyle = .named
        return rdtf.localizedString(fromTimeInterval: self.timeIntervalSince(Date()))
    }
    
    func getNameOfTheWeek() -> String{
        return Calendar.current.isDateInToday(self) ?
            "Today" : Calendar.current.isDateInTomorrow(self) ?
            "Tomorrow" : self.dayNameOfWeek()
    }
    
    func getTime()->String{
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df.string(from: self)
    }
    
    func getMediumDateTime()->String{
        let df = DateFormatter()
        df.dateFormat = "MMM d, h:mm a"
        return df.string(from: self)
    }
    
    func getLongDateTime()->String{
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d h:mm a"
        return df.string(from: self)
    }

    func getRegularDateTime()->String{
        let df = DateFormatter()
        df.dateFormat = "MMM d, YYYY h:mm a"
        return df.string(from: self)
    }
}

enum FavoriteTag {
    case facilitActivityType
    case facility
    case activityType
}

enum WalkthroughTag {
    case welcome
    case disclaimer
    case info
    case ready
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension String{
  func trim() -> String{
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
