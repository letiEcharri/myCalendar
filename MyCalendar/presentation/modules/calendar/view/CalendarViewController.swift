//
//  CalendarViewController.swift
//  MyCalendar
//
//  Created by Leticia Personal on 21/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol CalendarViewControllerDelegate {
    
}

class CalendarViewController: BaseViewController {

//    MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(CalendarCollectionViewCell.nib, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
            collectionView.backgroundColor = .clear
        }
    }
    
//    MARK: Properties
    var presenter: CalendarPresenterDelegate
   
//    MARK: Initialization
    init(presenter: CalendarPresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: "CalendarViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }

//   MARK: Functions
    
    func set(date: Date) {
        presenter.selectedDate = date
        collectionView.reloadData()
    }
}

//   MARK: Calendar Delegate
extension CalendarViewController: CalendarViewControllerDelegate {
    
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfDays()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }

        let firstDay = presenter.selectedDate.firstDayOfTheMonth.weekday
        
        if indexPath.row < 7 {
            cell.setDay(name: presenter.getDays()[indexPath.row])
        } else {
            if firstDay == 1  {
                if indexPath.row < 13 {
                    cell.set(day: "", selected: false)
                } else {
                    let day = "\(indexPath.row - 12)"
                    cell.set(day: day, selected: day == presenter.selectedDate.get(component: .day))
                }
                
            } else {
                if indexPath.row < (5 + firstDay) {
                    cell.set(day: "", selected: false)
                } else {
                    let day = "\(indexPath.row - 6 - (firstDay - 2))"
                    cell.set(day: day, selected: day == presenter.selectedDate.get(component: .day))
                }
            }
        }
        
        return cell
    }
}

//  MARK: - UICollectionViewDelegateFlowLayout

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/9.5, height: 40)
    }
}
