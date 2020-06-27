//
//  HomeDataSource.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

typealias EventsBlock = (EventModel?, ErrorModel?) -> Void
typealias HolidaysBlock = (HolidayModel?, ErrorModel?) -> Void

protocol HomeDataSourceDelegate {
    func getEvents(completion: @escaping EventsBlock)
    func getHolidays(completion: @escaping HolidaysBlock)
}

class HomeDataSource: BaseDataSource {
    struct URL {
        static let holidays = URLBase.holidays + "&country=ES&year=2019"
    }
}

extension HomeDataSource: HomeDataSourceDelegate {
    
    func getEvents(completion: @escaping EventsBlock) {
        executeDemoRequest(url: "events") { (response) in
            
            switch response {
            case .success(let data):
                if let data = data, let model = EventModel.getModelFrom(data) {
                    completion(model, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getHolidays(completion: @escaping HolidaysBlock) {
        executeRequest(url: URL.holidays) { (response) in
            switch response {
            case .success(let data):
                if let data = data, let model = HolidayModel.getModelFrom(data) {
                    completion(model, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
