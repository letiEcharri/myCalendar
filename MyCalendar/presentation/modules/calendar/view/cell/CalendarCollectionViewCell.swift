//
//  CalendarCollectionViewCell.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

// MARK: Properties
    static let identifier = "CalendarCollectionViewCell"
    
    static var nib:UINib {
        return UINib(nibName: "CalendarCollectionViewCell", bundle: nil)
    }
    
// MARK: Outlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var circleLeft: UIView!
    @IBOutlet weak var circleCenter: UIView!
    @IBOutlet weak var circleRight: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
// MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        circleLeft.circle()
        circleCenter.circle()
        circleRight.circle()
        
        numberLabel.font = .aller(style: .regular, size: 12)
    }

}

extension UIView {
    func circle() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
