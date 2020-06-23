//
//  CalendarSelectedButton.swift
//  MyCalendar
//
//  Created by Leticia Personal on 23/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

class CalendarSelectedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        self.titleLabel?.font = .aller(style: .regular, size: 15)
        self.setTitleColor(.white, for: .normal)
        self.circle()
        self.clipsToBounds = true
    }
    
    func selected(_ value: Bool) {
        self.backgroundColor = value ? Colors.appPurple : .clear
        if value {
//            self.shadow(radius: 1)
        }
    }
}
