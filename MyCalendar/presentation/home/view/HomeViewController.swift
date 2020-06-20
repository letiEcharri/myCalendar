//
//  HomeViewController.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate {
    
}

class HomeViewController: BaseViewController {
    
    let presenter: HomePresenterDelegate
    
    init(presenter: HomePresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "myCalendar"
    }

}

extension HomeViewController: HomeViewControllerDelegate {
    
}
