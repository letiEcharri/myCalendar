//
//  HomeRouter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol HomeRouterDelegate {
    func getCalendarViewController() -> CalendarViewController?
}

class HomeRouter: BaseRouter {
}

// MARK: RouterFactory
extension HomeRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        
        let datasource = HomeDataSource()
        let interactor = HomeInteractor(datasource)
        let router = HomeRouter(mainRouter: mainRouter)
        let presenter = HomePresenter(router: router, interactor: interactor)
        let viewController = HomeViewController(presenter: presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}

// MARK: HomeRouterDelegate
extension HomeRouter: HomeRouterDelegate {
    func getCalendarViewController() -> CalendarViewController? {
        return CalendarRouter.create(withMainRouter: mainRouter, parameters: nil) as? CalendarViewController
    }
}
