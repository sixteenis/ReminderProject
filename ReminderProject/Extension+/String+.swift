//
//  String+.swift
//  ReminderProject
//
//  Created by 박성민 on 7/7/24.
//

import Foundation

extension String {
    static func dateFormatString(date: Date) -> Self?{
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "yyyy.MM.dd(E)"
        let result = format.string(from: date)
        return result
    }
    
}
