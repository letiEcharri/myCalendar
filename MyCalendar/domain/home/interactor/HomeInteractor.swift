//
//  HomeInteractor.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

typealias EventsListBlock = (_ list: [HomePresenter.Model]?, _ error: String?) -> Void

protocol HomeInteractorDelegate {
    func getEvents(completion: @escaping EventsListBlock)
    func getHolidays(calendarEvents: [HomePresenter.Model]?, completion: @escaping EventsListBlock)
}

class HomeInteractor {
    
    let datasource: HomeDataSourceDelegate
    
    init(_ datasource: HomeDataSourceDelegate) {
        self.datasource = datasource
    }
}

extension HomeInteractor: HomeInteractorDelegate {
    func getEvents(completion: @escaping EventsListBlock) {
        datasource.getEvents { (events, error) in
            if let events = events, let list = events.events {
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "es_ES")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let dataGrouped = Dictionary(grouping: list) { (item) -> String in
                    let date = Calendar.current.dateComponents([.day, .year, .month], from: item.getDate())
                    return dateFormatter.string(from: Calendar.current.date(from: date) ?? Date())
                }
                
                let data = dataGrouped.compactMap { (key, value) in
                    HomePresenter.Model(date: key, items: value)
                }
                
                let dataSorted = data.sorted(by: { $0.date < $1.date } )
                completion(dataSorted, error?.error?.description)
            }
            completion(nil, error?.error?.description)
        }
    }
    
    func getHolidays(calendarEvents: [HomePresenter.Model]?, completion: @escaping EventsListBlock) {
        datasource.getHolidays { (model, error) in
            if let model = model {
                let holidays = model.holidays
                let formattedHolidays = holidays.compactMap { item in
                    EventItemModel(date: self.addYearTo(date: item.date), endDate: nil, title: item.name, place: nil, color: 0, holiday: true)
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "es_ES")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let holidayGrouped = Dictionary(grouping: formattedHolidays) { (item) -> String in
                    let date = Calendar.current.dateComponents([.day, .year, .month], from: item.getDate())
                    return dateFormatter.string(from: Calendar.current.date(from: date) ?? Date())
                }
                
                let dataHoliday = holidayGrouped.compactMap { (key, value) in
                    HomePresenter.Model(date: key, items: value)
                }
                
                if var calendarEvents = calendarEvents  {
                    for item in dataHoliday {
                        let checkDate = calendarEvents.firstIndex(where: { $0.date == item.date })
                        if let checkDate = checkDate {
                            calendarEvents[checkDate].items.append(contentsOf: item.items)
                        } else {
                            calendarEvents.append(item)
                        }
                    }
                    let dataSorted = calendarEvents.sorted(by: { $0.date < $1.date } )
                    completion(dataSorted, nil)
                } else {
                    let dataSorted = dataHoliday.sorted(by: { $0.date < $1.date } )
                    completion(dataSorted, nil)
                }
            } else {
                completion(nil, error?.error?.description)
            }
        }
    }
    
    private func addYearTo(date: String) -> String {
        return date.replacingOccurrences(of: "2019", with: "2020") + "T00:00:00+0200"
    }
}
