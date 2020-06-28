//
//  CalendarPresenter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol CalendarPresenterDelegate {
    var selectedDate: Date { get set }
    var events: [EventItemModel]? { get set }
    
    func getDays() -> [String]
    func numberOfDays() -> Int
    func getEventColors(date: Date?) -> [UIColor]?
}

class CalendarPresenter: BasePresenter {
    
//    MARK: Properties
    var ui: CalendarViewController?
    let router: CalendarRouterDelegate
    
    var selectedDate: Date = Date()
    var events: [EventItemModel]?
    
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
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: selectedDate), month: calendar.component(.month, from: selectedDate))
        if let date = calendar.date(from: dateComponents),
            let range = calendar.range(of: .day, in: .month, for: date) {
            let days = range.count
            let total = days + selectedDate.firstDayOfTheMonth.weekday
            
            return selectedDate.firstDayOfTheMonth.weekday == 1 ? total + 12 : total + 5
        }
        
        return 0
    }
    
    func getEventColors(date: Date?) -> [UIColor]? {
        var colors: [UIColor]?
        if let date = date {
            let eventsRetrieved = events?.filter {
                Calendar.current.compare(date, to: $0.getDate(), toGranularity: .day) == .orderedSame
            }
            
            if let eventsRetrieved = eventsRetrieved, eventsRetrieved.count > 0 {
                let colorsFiltered = eventsRetrieved.filter( { $0.color != nil } )
                if colorsFiltered.count > 0 {
                    colors = [UIColor]()
                    let retrivedColors = eventsRetrieved.compactMap { Color(rawValue: $0.color!)?.get() }
                    colors?.append(contentsOf: retrivedColors)
                }
            }
        }
        
        return colors
    }
}
