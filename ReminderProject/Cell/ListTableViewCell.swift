//
//  ListTableViewCell.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit
import SnapKit
final class ListTableViewCell: BaseTableViewCell {
    private let isCheck = UIButton()
    private let mainTitle = UILabel()
    
    //private let mainStack = UIStackView()
    private let subStack = UIStackView()
    private let subTitle = UILabel()
    private let dateLabel = UILabel()
    private let tagLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func setUpHierarchy() {
        contentView.addSubview(isCheck)
        contentView.addSubview(mainTitle)
        
        contentView.addSubview(subTitle)
        
        contentView.addSubview(subStack)
        subStack.addSubview(dateLabel)
        subStack.addSubview(tagLabel)
        
        // TODO: 스택으로 묶는거는 시간 남을 때 하자
    }
    override func setUpLayout() {
        isCheck.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(30)
        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(isCheck.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(10)
            make.leading.equalTo(isCheck.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        subStack.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(10)
            make.leading.equalTo(isCheck.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(subStack.snp.leading)
            make.top.equalTo(subStack.snp.top)
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing)
            make.top.equalTo(subStack.snp.top)
        }
        
    }
    override func setUpView() {
        isCheck.setImage(UIImage(systemName: "circle"), for: .normal)
        isCheck.setTitleColor(.placeholderClor, for: .normal)
        
        mainTitle.text = "키보드 구매"
        mainTitle.textColor = .textColor
        
        subTitle.text = "예븐 키캡 알아보기"
        subTitle.textColor = .placeholderClor
        
        dateLabel.text = "1231231"
        tagLabel.text = "###@@@2213"
    }

}

