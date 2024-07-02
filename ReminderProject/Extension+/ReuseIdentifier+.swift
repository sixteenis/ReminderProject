//
//  ReuseIdentifier+.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var id: String { get }
}
extension ReuseIdentifierProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UIView: ReuseIdentifierProtocol{}
