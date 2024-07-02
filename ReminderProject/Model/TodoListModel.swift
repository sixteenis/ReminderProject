//
//  TodoListModel.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import Foundation
import RealmSwift

class TodoListModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String//메모제목(필수)
    @Persisted var memo: String?//메모내용(옵션)
    @Persisted var tag: String?//카테고리(필수)
    @Persisted var date: Date?//등록일(필수)
    @Persisted var isCheck: Bool = false
    
    convenience init(title: String, memo: String? = nil, tag: String? = nil, date: Date? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.tag = tag
        self.date = date
    }

}
