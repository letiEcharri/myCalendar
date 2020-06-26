//
//  EventModel.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

struct EventModel: StructCodable {
    var events: [EventItemModel]?
}

struct EventItemModel: StructCodable {
    var date: String
    var endDate: String?
    var title: String
    var place: String?
    var color: Int?
    
    func getDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.date(from: self.date) ?? Date()
    }
    
    func getEndDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "es_ES")
        return self.endDate == nil ? nil : dateFormatter.date(from: self.endDate!)
    }
    
    func getColor() -> Color? {
        return Color(rawValue: self.color ?? 1)
    }
}

enum Color: Int {
    case blue = 1
    case red = 2
    case brown = 3
    case green = 4
    
    func get() -> UIColor {
        switch self {
        case .blue:
            return .blue
        case .red:
            return .red
        case .brown:
            return .brown
        case .green:
            return .green
        }
    }
}
