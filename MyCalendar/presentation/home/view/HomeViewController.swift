//
//  HomeViewController.swift
//  MyCalendar
//
//  Created by Leticia Personal on 20/06/2020.
//  Copyright © 2020 Leticia Echarri. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate {
    func reloadData()
}

class HomeViewController: BaseViewController {
    
//    MARK: Outlets
    @IBOutlet weak var topView: UIView! {
        didSet {
            topView.backgroundColor = Colors.lightPurple
        }
    }
    @IBOutlet weak var leftArrowButton: UIButton! {
        didSet {
            leftArrowButton.tintColor = Colors.appPurple
        }
    }
    @IBOutlet weak var rightArrowButton: UIButton!{
        didSet {
            rightArrowButton.tintColor = Colors.appPurple
        }
    }
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.font = .aller(style: .regular, size: 20)
        }
    }
    @IBOutlet weak var calendarView: UIView! {
        didSet {
            calendarView.backgroundColor = Colors.lightPurple
        }
    }
    
    @IBOutlet weak var calendarBottomMark: UIView! {
        didSet {
            calendarBottomMark.backgroundColor = Colors.appPurple
            calendarBottomMark.layer.cornerRadius = calendarBottomMark.frame.height / 2
            calendarBottomMark.clipsToBounds = true
            calendarBottomMark.shadow()
        }
    }
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        }
    }
    
    //    MARK: Properties
    let titlePicker = UIPickerView()
    var calendarViewController: CalendarViewController?
    
    let maxCalendarHeigh: CGFloat = 300
    let minCalendarHeigh: CGFloat = 15
    var closedCalendar = true
    
    var presenter: HomePresenterDelegate

//    MARK: Initialization
    init(presenter: HomePresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        title = "myCalendar"
        configureTitlePicker()
        configureCalendar()
    }
    
//  MARK: Outlet Actions
    
    @IBAction func moveMonthAction(_ sender: UIButton) {
        let date = Calendar.current.date(byAdding: .month, value: sender.tag == 0 ? -1 : 1, to: presenter.pickerSelectedDate ?? Date()) ?? Date()
        presenter.pickerSelectedDate = date
        calendarViewController?.set(date: date)
        titleTextField.text = presenter.format(date: date).capitalized
    }
    
//   MARK: Functions
    
    private func configureTitlePicker() {
        //Formate Date
        titlePicker.delegate = self
        titlePicker.dataSource = self
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(acceptTitlePicker));
        toolbar.setItems([button], animated: true)
        
        titleTextField.inputAccessoryView = toolbar
        titleTextField.inputView = titlePicker
        titleTextField.delegate = self
        titleTextField.text = "\(presenter.currentMonth.capitalized) \(presenter.currentYear)"
        
        let selected = presenter.getSelectedIndex()
        titlePicker.selectRow(selected.month, inComponent: 0, animated: true)
        titlePicker.selectRow(selected.year, inComponent: 1, animated: true)
    }
    
    @objc
    private func acceptTitlePicker() {
        titleTextField.resignFirstResponder()
    }
    
    @objc
    private func titleTexFieldAction(_ textField: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    private func configureCalendar() {
        if let controller = presenter.getCalendarViewController() {
            calendarViewController = controller
            addChild(calendarViewController!)
            calendarView.addSubview(calendarViewController!.view)
            calendarViewController!.didMove(toParent: self)
            calendarViewController!.view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                calendarViewController!.view.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 0),
                calendarViewController!.view.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: 0),
                calendarViewController!.view.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 0),
                calendarViewController!.view.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: -11)
            ])
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        calendarView.addGestureRecognizer(panGesture)
        
        calendarViewController?.set(events: presenter.retrieveEvents())
    }
    
    @objc
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view).y
        
        switch gesture.state {
        case .began:
            closedCalendar = calendarViewHeight.constant == minCalendarHeigh
            
        case .changed:
            let value = closedCalendar ? translation : maxCalendarHeigh + translation
            calendarViewHeight.constant = min(max(value, minCalendarHeigh), maxCalendarHeigh)
            
        case .ended:
            calendarViewHeight.constant = calendarViewHeight.constant > (maxCalendarHeigh / 2) ? maxCalendarHeigh : minCalendarHeigh
            
            closedCalendar = calendarViewHeight.constant == minCalendarHeigh
            
        default:
            break
        }
        
//        print("\(translation) - \(calendarViewHeight.constant)")
    }

    
}

//  MARK: HomeViewControllerDelegate
extension HomeViewController: HomeViewControllerDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.selectRow(at: self.presenter.getSelectedIndexPath(), animated: false, scrollPosition: .top)
        }
    }
}

//  MARK: Picker Delegate & DataSource
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? presenter.getMonths().count : presenter.getYears().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return component == 0 ? presenter.getMonths()[row] : presenter.getYears()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = presenter.getMonths()[pickerView.selectedRow(inComponent: 0)].capitalized
        let year = presenter.getYears()[pickerView.selectedRow(inComponent: 1)]
        
        titleTextField.text = "\(month) \(year)"
        presenter.saveSelectedDate(month: pickerView.selectedRow(inComponent: 0) + 1, year: year)
    }
}

//  MARK: UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        textField.resignFirstResponder()
        return false
    }
}

//  MARK: Table Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfItemsFor(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let item = presenter.events[indexPath.section].items[indexPath.row]
        
        cell.set(data: item)
        cell.timeLabel.isHidden = indexPath.row != 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
