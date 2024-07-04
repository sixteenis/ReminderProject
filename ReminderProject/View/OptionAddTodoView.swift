//
//  OptionAddTodoView.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit

import SnapKit

final class OptionAddTodoView: BaseButtonView {
    private let maintitle = UILabel()
    private let inputTitle = UILabel()
    private let symbol = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func setUpHierarchy() {
        addSubview(maintitle)
        addSubview(inputTitle)
        addSubview(symbol)
    }
    override func setUpLayout() {
        maintitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
        inputTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(symbol.snp.leading).offset(-15)
        }
        symbol.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(15)
        }
    }
    override func setUpView() {
        backgroundColor = .box
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        
        maintitle.textColor = AddTodoTitle.textColor
        maintitle.font = AddTodoTitle.textFont
        maintitle.textAlignment = AddTodoTitle.mainTextalignment
        
        inputTitle.textColor = AddTodoTitle.textColor
        inputTitle.font = AddTodoTitle.textFont
        inputTitle.textAlignment = AddTodoTitle.subTextalignment
        
        symbol.image = .arrow
        symbol.tintColor = .whiteText
    }
    func changeDate(type: AddTodoTitle) {
        maintitle.text = type.rawValue
        
    }
    func changeInputTitle(_ text: String) {
        self.inputTitle.text = text
    }
}
