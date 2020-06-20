//
//  MainRouter.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
    func show(viewController: UIViewController, sender: Any?)
    func present(viewController: UIViewController, animated: Bool, completion:(() -> Void)?)
    func push(navigationController: UINavigationController?, viewController: UIViewController, animated: Bool)
}

protocol RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterProtocol, parameters: AnyObject?) -> UIViewController
}

class MainRouter {
    let window: UIWindow
    
    var rootViewController: UIViewController {
        
        guard let rootViewController = window.rootViewController else {
            fatalError("There is no rootViewController installed on the window")
        }
        
        return rootViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension MainRouter {
    
    func presentRootViewController() {
        let viewController = HomeRouter.create(withMainRouter: self, parameters: nil)
        let rootViewController = UINavigationController(rootViewController: viewController)
        
//        let tabBar = TabBarViewController(mainRouter: self)
//        let rootViewController = UINavigationController(rootViewController: tabBar)
        window.rootViewController = rootViewController
    }
}

extension MainRouter: MainRouterProtocol {
    func show(viewController: UIViewController, sender: Any?) {
        rootViewController.show(viewController, sender: sender)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion:(() -> Void)?) {
        rootViewController.present(viewController, animated: animated, completion: completion)
    }
    
    func push(navigationController: UINavigationController?, viewController: UIViewController, animated: Bool) {
        if navigationController == nil {
            rootViewController.navigationController!.pushViewController(viewController, animated: animated)
        } else {
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}
