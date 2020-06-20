//
//  BaseRouter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol BaseRouterDelegate {
    
}

class BaseRouter {
    let mainRouter: MainRouterProtocol
    
    init(mainRouter: MainRouterProtocol) {
        self.mainRouter = mainRouter
    }
}

extension BaseRouter: BaseRouterDelegate {
    
}
