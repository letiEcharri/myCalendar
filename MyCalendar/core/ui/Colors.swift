//
//  Colors.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

enum Color: Int {
    case appPurpe = 0
    case blue = 1
    case red = 2
    case brown = 3
    case green = 4
    
    func get() -> UIColor {
        switch self {
        case .appPurpe:
            return Colors.appPurple
        case .blue:
            return .blue
        case .red:
            return .red
        case .brown:
            return .brown
        case .green:
            return .systemGreen
        }
    }
}

class Colors {
    // #B153A1 177 83 161
    static let appPurple = UIColor(red: 177/255.0, green: 83/255.0, blue: 161/255.0, alpha: 1)
    
    // #EDD3E9 237 211 233
    static let lightPurple = UIColor(red: 237/255.0, green: 211/255.0, blue: 233/255.0, alpha: 1)
}
