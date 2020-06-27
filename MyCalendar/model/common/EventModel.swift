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
    var holiday: Bool?
    
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
    
    func isHoliday() -> Bool {
        return holiday != nil
    }
}
