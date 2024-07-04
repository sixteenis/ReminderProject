//
//  MainCollectionViewCell.swift
//  ReminderProject
//
//  Created by 박성민 on 7/4/24.
//

import UIKit

import SnapKit
final class MainCollectionViewCell: UICollectionViewCell {
    private let rootView = UIView()
    private let viewImage = UIView()
    private let image = UIImageView()
    private let label = UILabel()
    private let count = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    
    func setUpHierarchy() {
        contentView.addSubview(rootView)
        contentView.addSubview(viewImage)
        viewImage.addSubview(image)
        contentView.addSubview(label)
        contentView.addSubview(count)
    }
    
    func setUpLayout() {
        rootView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        viewImage.snp.makeConstraints { make in
            make.top.leading.equalTo(rootView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(40)
        }
        image.snp.makeConstraints { make in
            make.center.equalTo(viewImage)
            make.size.equalTo(25)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(15)
            make.leading.equalTo(rootView.safeAreaLayoutGuide).inset(10)
        }
        count.snp.makeConstraints { make in
            make.top.trailing.equalTo(rootView.safeAreaLayoutGuide).inset(10)
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        rootView.layer.masksToBounds = true
        rootView.layer.cornerRadius = 15
        
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        viewImage.layer.cornerRadius = viewImage.frame.width / 2
        
    }
    func setUpView() {
        rootView.backgroundColor = .box
        
        image.tintColor = .whiteText
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        
        count.font = .boldSystemFont(ofSize: 30)
        count.textColor = .whiteText
        
    }
    func changeView(type: MainList) {
        image.image = type.symbol
        viewImage.backgroundColor = type.color
        
        label.text = type.rawValue
        
        count.text = "10"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
