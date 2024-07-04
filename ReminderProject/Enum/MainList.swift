//
//  MainList.swift
//  ReminderProject
//
//  Created by 박성민 on 7/4/24.
//

import UIKit

enum MainList: String, CaseIterable {
    case today = "오늘"
    case notYet = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case complet = "완료됨"
    
    var color: UIColor {
        switch self {
        case .today:
            return UIColor.systemBlue
        case .notYet:
            return UIColor.systemRed
        case .all:
            return UIColor.systemGray
        case .flag:
            return UIColor.systemYellow
        case .complet:
            return UIColor.systemCyan
        }
    }
    var symbol: UIImage {
        switch self {
        case .today:
            return UIImage(systemName: "calendar")!
        case .notYet:
            return UIImage(systemName: "calendar")!
        case .all:
            return UIImage(systemName: "tray.fill")!
        case .flag:
            return UIImage(systemName: "flag.fill")!
        case .complet:
            return UIImage(systemName: "checkmark")!
        }
    }
}
