//
//  HomePresenter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

class HomePresenter: BasePresenter {

//    MARK: Properties
    var currentMonth: String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "es_ES")
        let month = dateFormatter.string(from: now)
        return month
    }
    
    var currentYear: String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: now)
        return year
    }
    
    var pickerSelectedDate: Date? = Date()
    
    
    var ui: HomeViewControllerDelegate?
    let router: HomeRouterDelegate

//    MARK: Initialization
    init(router: HomeRouterDelegate) {
        self.router = router
    }
}

//    MARK: HomePresenterDelegate
extension HomePresenter: HomePresenterDelegate {
    func getMonths() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        
        return formatter.monthSymbols
    }
    
    func getYears() -> [String] {
        let formatter = DateFormatter()
        
        return formatter.years(1900...2100)
    }
    
    func getSelectedIndex() -> (month: Int, year: Int) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: now)) ?? 2
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: now)) ?? 0
        
        let indexMonth = month - 1
        let indexYear = year - 1900
        
        return (month: indexMonth, year: indexYear)
    }
    
    func saveSelectedDate(month: Int, year: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy"
        if let date = dateFormatter.date(from: "\(month + 1)-\(year)") {
            pickerSelectedDate = date
        }
    }
}
