//
//  PriorityOptionViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit
import SnapKit

class PriorityOptionViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private let pickerView = UIPickerView()
    private var selectedPriority: Int = 0
    var completion: ((Int,String) -> ())?
    private let priorities = ["낮음", "중간", "높음"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion?(selectedPriority, priorities[selectedPriority])
    }
    override func setUpHierarchy() {
        view.addSubview(pickerView)
    }
    
    override func setUpLayout() {
        pickerView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }
    
    override func setUpView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // UIPickerViewDataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    // UIPickerViewDelegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch priorities[row] {
        case "낮음":
            selectedPriority = 0
        case "중간":
            selectedPriority = 1
        case "높음":
            selectedPriority = 2
        default:
            selectedPriority = 0
        }
        print("Selected priority: \(priorities[row]), Int value: \(selectedPriority)")
    }
}
