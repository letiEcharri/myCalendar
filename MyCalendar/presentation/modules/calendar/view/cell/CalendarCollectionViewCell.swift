//
//  CalendarCollectionViewCell.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol CalendarCollectionViewCellDelegate {
    func click(day: Date)
}

class CalendarCollectionViewCell: UICollectionViewCell {

// MARK: Properties
    static let identifier = "CalendarCollectionViewCell"
    
    static var nib:UINib {
        return UINib(nibName: "CalendarCollectionViewCell", bundle: nil)
    }
    
    var date: Date?
    
    var delegate: CalendarCollectionViewCellDelegate?
    
// MARK: Outlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var numberButton: CalendarSelectedButton!
    
// MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
// MARK: Functions
    
    private func configureView() {
        self.backgroundColor = .clear
        numberLabel.font = .aller(style: .regular, size: 12)
        numberButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        for item in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(item)
        }
        stackView.layoutIfNeeded()
    }
    
    private func addCircle(color: UIColor) {
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = color
        
        circleView.widthAnchor.constraint(equalToConstant: 6).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        
        circleView.circle()
        
        stackView.addArrangedSubview(circleView)
        stackView.layoutIfNeeded()
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        delegate?.click(day: date ?? Date())
    }
    
    func set(day: String, selected: Bool, date: Date?, events: [UIColor]?) {
        self.date = date
        numberLabel.text = day
        numberLabel.font = .aller(style: .regular, size: 15)
        numberButton.setTitle(selected ? day : "", for: .normal)
        numberButton.selected(selected)
        numberButton.tag = Int(day) ?? 0
        
        for item in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(item)
        }
        stackView.layoutIfNeeded()
        if let events = events {
            for (index, item) in events.enumerated() where (index < 3) {
                addCircle(color: item)
            }
        }
    }
    
    func setDay(name: String) {
        numberLabel.text = name.capitalized
        numberLabel.font = .aller(style: .bold, size: 15)
        numberButton.setTitle("", for: .normal)
        numberButton.selected(false)
        self.date = nil
        
        for item in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(item)
        }
        stackView.layoutIfNeeded()
    }
}
