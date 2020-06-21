//
//  CalendarPresenter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

protocol CalendarPresenterDelegate {
    
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
    
}
