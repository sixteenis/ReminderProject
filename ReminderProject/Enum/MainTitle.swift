//
//  MainTitle.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//
import UIKit


enum MainTitle: String {
    case all = "전체"
    
    var font: UIFont {
        switch self {
        case .all:
            return UIFont.boldSystemFont(ofSize: 30)
            
        }
        
    }
    var color: UIColor {
        switch self {
        case .all:
            return UIColor.textColor
        }
    }
}
