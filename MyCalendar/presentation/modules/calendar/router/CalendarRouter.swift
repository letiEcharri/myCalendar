//
//  CalendarRouter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol CalendarRouterDelegate {
    
}

class CalendarRouter: BaseRouter {}

extension CalendarRouter: RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController {
        
        let router = CalendarRouter(mainRouter: mainRouter)
        let presenter = CalendarPresenter(router: router)
        let viewController = CalendarViewController(presenter: presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}

extension CalendarRouter: CalendarRouterDelegate {
    
}
