//
//  UIView+Style.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

extension UIView {
    func circle() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
