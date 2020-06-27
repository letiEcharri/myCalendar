//
//  HolidayModel.swift
//  MyCalendar
//
//  Created by Leticia Personal on 27/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

// MARK: - HolidayModel
struct HolidayModel: StructCodable {
    let status: Int
    let warning: String
    let requests: RequestsHolidays
    let holidays: [Holiday]
}

// MARK: - Holiday
struct Holiday: StructCodable {
    let name, date, observed: String
    let holidayPublic: Bool
    let country: CountryHoliday
    let uuid: String
    let weekday: WeekdayHoliday

    enum CodingKeys: String, CodingKey {
        case name, date, observed
        case holidayPublic = "public"
        case country, uuid, weekday
    }
}

enum CountryHoliday: String, Codable {
    case es = "ES"
}

// MARK: - Weekday
struct WeekdayHoliday: StructCodable {
    let date, observed: DateClass
}

// MARK: - DateClass
struct DateClass: StructCodable {
    let name: WeekdayName
    let numeric: String
}

enum WeekdayName: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

// MARK: - Requests
struct RequestsHolidays: StructCodable {
    let used, available: Int
    let resets: String
}
