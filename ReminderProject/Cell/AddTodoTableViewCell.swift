//
//  AddTodoTableViewCell.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit
import SnapKit
final class AddTodoTableViewCell: BaseTableViewCell {
    private let maintitle = UILabel()
    private let inputTitle = UILabel()
    private let symbol = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func setUpHierarchy() {
        contentView.addSubview(maintitle)
        contentView.addSubview(inputTitle)
        contentView.addSubview(symbol)
    }
    override func setUpLayout() {
        maintitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        inputTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(symbol.snp.leading)
        }
        symbol.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(15)
        }
        
    }
    override func setUpView() {
        contentView.backgroundColor = .box
        
        maintitle.textColor = AddTodoTitle.textColor
        maintitle.font = AddTodoTitle.textFont
        maintitle.textAlignment = AddTodoTitle.mainTextalignment
        
        inputTitle.textColor = AddTodoTitle.textColor
        inputTitle.font = AddTodoTitle.textFont
        inputTitle.textAlignment = AddTodoTitle.subTextalignment
        
        symbol.image = .arrow
        symbol.tintColor = .white
    }
    func changeDate(type: AddTodoTitle) {
        maintitle.text = type.rawValue
    }
}
