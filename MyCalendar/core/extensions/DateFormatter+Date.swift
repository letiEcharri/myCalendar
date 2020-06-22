//
//  DateFormatter+Date.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

extension DateFormatter {
    func years<R: RandomAccessCollection>(_ range: R) -> [String] where R.Iterator.Element == Int {
        setLocalizedDateFormatFromTemplate("yyyy")
        var comps = DateComponents(month: 1, day: 1)
        var res = [String]()
        for y in range {
            comps.year = y
            if let date = calendar.date(from: comps) {
                res.append(string(from: date))
            }
        }

        return res
    }
}

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
