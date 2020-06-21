//
//  CalendarPresenter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

protocol CalendarPresenterDelegate {
    func getDays() -> [String]
}

class CalendarPresenter: BasePresenter {
    
//    MARK: Properties
    var ui: CalendarViewController?
    let router: CalendarRouterDelegate
    
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
}
