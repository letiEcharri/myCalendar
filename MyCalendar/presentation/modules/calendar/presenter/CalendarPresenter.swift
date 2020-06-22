//
//  CalendarPresenter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

protocol CalendarPresenterDelegate {
    var selectedMonth: Date { get set }
    
    func getDays() -> [String]
    func numberOfDays() -> Int
}

class CalendarPresenter: BasePresenter {
    
//    MARK: Properties
    var ui: CalendarViewController?
    let router: CalendarRouterDelegate
    
    var selectedMonth: Date = Date()
    
//    MARK: Initialization
    init(router: CalendarRouterDelegate) {
        self.router = router
    }
}

//    MARK: CalendarPresenterDelegate
extension CalendarPresenter: CalendarPresenterDelegate {
    
    func getDays() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        if var days = formatter.shortWeekdaySymbols {
            let sunday = days[0]
            days.remove(at: 0)
            days.append(sunday)
            return days
        }
        
        return [String]()
    }
    
    func numberOfDays() -> Int {
        
        let calendar = Calendar.current
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: selectedMonth), month: calendar.component(.month, from: selectedMonth))
        if let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date) {
            let days = range.count
            let total = days + selectedMonth.firstDayOfTheMonth.weekday
            
            return selectedMonth.firstDayOfTheMonth.weekday == 1 ? total + 12 : total + 5
        }
        
        return 0
    }
}
