//
//  HomeDataSource.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

typealias EventsBlock = (EventModel?, ErrorModel?) -> Void

protocol HomeDataSourceDelegate {
    func getEvents(completion: @escaping EventsBlock)
}

class HomeDataSource: BaseDataSource {
    
}

extension HomeDataSource: HomeDataSourceDelegate {
    
    func getEvents(completion: @escaping EventsBlock) {
        executeRequest(url: "events") { (response) in
            
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
}
