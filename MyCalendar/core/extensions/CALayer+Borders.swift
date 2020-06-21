//
//  CALayer+Borders.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

       let border = CALayer()

       switch edge {
       case UIRectEdge.top:
           border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)

       case UIRectEdge.bottom:
           border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)

       case UIRectEdge.left:
           border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)

       case UIRectEdge.right:
           border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)

       default: do {}
       }

       border.backgroundColor = color.cgColor

       addSublayer(border)
    }
}
