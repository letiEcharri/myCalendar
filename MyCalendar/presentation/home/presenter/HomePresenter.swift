//
//  HomePresenter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate {
    
}

class HomePresenter: BasePresenter {
    
    var ui: HomeViewControllerDelegate?
    let router: HomeRouterDelegate
    
    init(router: HomeRouterDelegate) {
        self.router = router
    }
}

extension HomePresenter: HomePresenterDelegate {
    
}
