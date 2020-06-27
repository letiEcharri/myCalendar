//
//  HomeTableViewCell.swift
//  MyCalendar
//
//  Created by Leticia Personal on 26/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

//    MARK: Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeFullLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
//    MARK: Properties
    static let identifier = "HomeTableViewCell"
    
    static var nib:UINib {
        return UINib(nibName: "HomeTableViewCell", bundle: nil)
    }
    
    var data: EventItemModel?
//    var date: Date?
//    var place: String?
//    var color: UIColor?
    
//    MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    private func configureView() {
        timeLabel.font = .aller(style: .light, size: 18)
        titleLabel.font = .aller(style: .bold, size: 16)
        timeFullLabel.font = .aller(style: .regular, size: 14)
        placeLabel.font = .aller(style: .regular, size: 14)
        
        timeLabel.textColor = Colors.appPurple
        
        mainView.layer.cornerRadius = 5
    }
    
    func set(data: EventItemModel) {
        self.data = data
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        
        dateFormatter.dateFormat = "dd MMM"
        let day = dateFormatter.string(from: data.getDate())
        timeLabel.text = day.uppercased()
        if data.getDate().isToday() {
            timeLabel.font = .aller(style: .bold, size: 18)
        }
        
        dateFormatter.dateFormat = "HH:mm"
        var hour = dateFormatter.string(from: data.getDate())
        if let endHour = data.getEndDate() {
            hour += " - " + dateFormatter.string(from: endHour)
        }
        timeFullLabel.text = hour
        
        titleLabel.text = data.title
        
        placeLabel.isHidden = true
        if let place = data.place {
            placeLabel.text = place
            placeLabel.isHidden = false
        }
        
        mainView.backgroundColor = data.getColor()?.get()
    }
    
}

extension Date {
    
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
}
