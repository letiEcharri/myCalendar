//
//  Fonts.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

extension UIFont {
    
    public enum AllerStyle {
        case regular
        case bold
        case boldItalic
        case italic
        case display
        case light
        case lightItalic
    }
    
    public static func organico(size: CGFloat) -> UIFont {
        return UIFont(name: "Organico DEMO", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func aller(style: AllerStyle, size: CGFloat) -> UIFont {
        switch style {
        case .regular:
            return UIFont(name: "Aller", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont(name: "Aller-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .boldItalic:
            return UIFont(name: "Aller-BoldItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        case .italic:
            return UIFont(name: "Aller-Italic", size: size) ?? UIFont.systemFont(ofSize: size)
        case .display:
            return UIFont(name: "AllerDisplay", size: size) ?? UIFont.systemFont(ofSize: size)
        case .light:
            return UIFont(name: "Aller-Light", size: size) ?? UIFont.systemFont(ofSize: size)
        case .lightItalic:
            return UIFont(name: "Aller-LightItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}

// Run this to get all system fonts
/*for family: String in UIFont.familyNames {
    print("\(family)")
    for names: String in UIFont.fontNames(forFamilyName: family) {
        print("== \(names)")
    }
}*/
