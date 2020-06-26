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
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "es_ES")
                
                let dataGrouped = Dictionary(grouping: list) { (item) -> String in
                    let date = Calendar.current.dateComponents([.day, .year, .month], from: (item.getDate()))
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
}
