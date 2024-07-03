//
//  DateOptionViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit
import SnapKit
class DateOptionViewController: BaseViewController {
    private let datePicker = UIDatePicker()
    private var selectDate: Date?
    var completion: ((Date?) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion?(selectDate)
    }
    override func setUpHierarchy() {
        view.addSubview(datePicker)
    }
    override func setUpLayout() {
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    @objc func dateChange(_ sender: UIDatePicker) {
        selectDate = sender.date
        print(#function)
    }
    

    

}
