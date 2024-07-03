//
//  BaseButtonView.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit

class BaseButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
