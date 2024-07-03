//
//  TagOptionViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit

class TagOptionViewController: BaseViewController {
    private let textFiled = UITextField()
    var completion: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion?(textFiled.text ?? "")
    }
    override func setUpHierarchy() {
        view.addSubview(textFiled)
    }
    override func setUpLayout() {
        textFiled.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        textFiled.placeholder = "원하는 태그를 입력해주세요."
        textFiled.textColor = .textColor
        textFiled.font = .boldSystemFont(ofSize: 16)
    }
    
}
