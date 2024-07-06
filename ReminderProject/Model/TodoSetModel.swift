//
//  TodoSetModel.swift
//  ReminderProject
//
//  Created by 박성민 on 7/4/24.
//

import Foundation

final class TodoSetModel {
    private var title: String!
    private var memo: String?
    private var tag: String?
    var date: String?
    private var priority: Int = 0
    private var isFinish: Bool = false // true
    private var isFlag: Bool = false // true
    //
    
    func setMemo(_ input: String){
        self.memo = input
    }
    func setTag(_ input: String){
        self.tag = input
    }
    func setdate(_ input: String){
        self.date = input
    }
    func setPriority(_ input: Int){
        self.priority = input
    }
    func setIsFinish(_ input: Bool){
        self.isFinish = input
    }
    func setFlag(_ input: Bool){
        self.isFlag = input
    }
    
    func makeModel(_ title: String) -> TodoListModel {
        return TodoListModel(title: title, memo: self.memo, tag: self.tag, date: self.date, priority: self.priority, isFinish: self.isFinish, isFlag: self.isFlag)
    }
}

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
