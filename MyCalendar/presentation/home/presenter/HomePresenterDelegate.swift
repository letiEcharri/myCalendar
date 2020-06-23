//
//  HomePresenterDelegate.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate {
    
    var currentMonth: String { get }
    var currentYear: String { get }
    var pickerSelectedDate: Date? { get set }
    
    func getMonths() -> [String]
    func getYears() -> [String]
    func getSelectedIndex() -> (month: Int, year: Int)
    func saveSelectedDate(month: Int, year: String)
    func getCalendarViewController() -> CalendarViewController?
    func format(date: Date) -> String
}
