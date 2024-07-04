//
//  TodoSetModel.swift
//  ReminderProject
//
//  Created by 박성민 on 7/4/24.
//

//import Foundation
//
//class TodoSetModel {
//    static var title: String!
//    static var memo: String?
//    static var tag: String?
//    static var date: Date?
//    static var priority: Int?
//    
//    func setTitle(_ input: String){
//        Self.title = input
//    }
//}

//class TodoListModel: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted(indexed: true) var title: String//메모제목(필수)
//    @Persisted var memo: String?//메모내용(옵션)
//    @Persisted var tag: String?//카테고리(옵션)
//    @Persisted var date: Date?//등록일(옵션)
//    @Persisted var priority: Int? //우선순위
//    // TODO: enum타입으로 넣어주고 싶다...
//    @Persisted var isCheck: Bool = false
//    
//    convenience init(title: String, memo: String? = nil, tag: String? = nil, date: Date? = nil, priority: Int? = nil) {
//        self.init()
//        self.title = title
//        self.memo = memo
//        self.tag = tag
//        self.date = date
//        self.priority = priority
//    }
//
//}