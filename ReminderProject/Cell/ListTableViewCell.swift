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
    var checkCloser: () -> () = {}
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
            make.leading.equalTo(dateLabel.snp.trailing).offset(10)
            make.top.equalTo(subStack.snp.top)
        }
        
    }
//remake
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        dateLabel.text = ""
//    }
    
    override func setUpView() {
        isCheck.setImage(UIImage(systemName: "circle"), for: .normal)
        isCheck.setTitleColor(.placeholderClor, for: .normal)
        isCheck.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        
        mainTitle.textColor = .textColor
        
        subTitle.isHidden = true
        subTitle.textColor = .placeholderClor
        
        
        dateLabel.isHidden = true
        
        tagLabel.isHidden = true
    }
    func changeView(data: TodoListModel) {
        let image = data.isFinish ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        self.isCheck.setImage(image, for: .normal)
        var priorityStrig = ""
        for _ in 0..<data.priority {
            priorityStrig += "!"
        }
        
        self.mainTitle.text = priorityStrig + data.title
        if let sub = data.memo {
            subTitle.text = sub
            subTitle.isHidden = false
        }else{
            subTitle.text = nil
            subTitle.isHidden = true
        }
        if let tag = data.tag {
            if tag != "" {
                tagLabel.text = "#" + tag
                tagLabel.isHidden = false
            }
        }else{
            tagLabel.text = nil
            tagLabel.isHidden = true
        }
        if data.date != nil{
            dateLabel.text = data.date
            dateLabel.isHidden = false
        }else{
            dateLabel.text = ""
            dateLabel.isHidden = true
        }
    
    }
    @objc func checkButtonTapped() {
        checkCloser()
    }

}

