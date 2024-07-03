//
//  AddTodoTitle.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit


enum AddTodoTitle: String {
    case date = "마감일"
    case tag = "태그"
    case priority = "우선 순위"
    case image = "이미지 추가"
    
    
    static let textFont = UIFont.systemFont(ofSize: 14)
    static let textColor = UIColor.whiteText
    static let mainTextalignment = NSTextAlignment.left
    static let subTextalignment = NSTextAlignment.right
}
