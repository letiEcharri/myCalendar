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
    
    func shadow(radius: CGFloat = 2) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
