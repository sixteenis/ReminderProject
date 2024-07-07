//
//  TodoListRepository.swift
//  ReminderProject
//
//  Created by 박성민 on 7/4/24.
//

import Foundation
import RealmSwift

final class TodoListRepository {
    static var countList: [Int] {
            return [todayCount, notyetCount, allCount, flagCount, finishCount]
        }
    static var todayCount = 0
    static var notyetCount = 0
    static var allCount = 0
    static var flagCount = 0
    static var finishCount = 0
    private let realm = try! Realm()
    private let today = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "yyyy.MM.dd(E)"
        let today = format.string(from: Date())
        let result = format.date(from: today)
        return result
    }()
    func createItem(_ data: TodoListModel) {
        print(realm.configuration.fileURL!)
        try! realm.write {
            realm.add(data)
        }
    }
    func allFetch() {
        let _ = self.fetchToday()
        let _ = self.fetchNotyet()
        let _ = self.fetchAll()
        let _ = self.fetchFlag()
        let _ = self.fetchFinish()
    }
    //오늘
    func fetchToday() -> Results<TodoListModel> {
        let data = realm.objects(TodoListModel.self)
        let result = data.where {
            $0.date == today
        }
        Self.todayCount = result.count
        return result
    }
    //예정
    func fetchNotyet() -> Results<TodoListModel> {
            let data = realm.objects(TodoListModel.self)
            let result = data.where {
                $0.date > today
            }
        Self.notyetCount = result.count
            return result
        }
    //전체
    func fetchAll() -> Results<TodoListModel> {
        let data = realm.objects(TodoListModel.self)
        let result = data.where {
            $0.isFinish == false
        }
        Self.allCount = result.count
        return result
    }
    //깃발 표시
    func fetchFlag() -> Results<TodoListModel> {
        let data = realm.objects(TodoListModel.self)
        let result = data.where {
            $0.isFlag == true
        }
        Self.flagCount = result.count
        return result
    }
    //완료됨
    func fetchFinish() -> Results<TodoListModel> {
        let data = realm.objects(TodoListModel.self)
        let result = data.where {
            $0.isFinish == true
        }
        Self.finishCount = result.count
        return result
    }
    
    
    // MARK: -  기능 부분
    func deleteItem(_ data: TodoListModel) {
        try! realm.write {
            realm.delete(data)
        }
    }
    func changeItem(_ data: TodoListModel) {
        try! realm.write {
            let result = !data.isFinish
            data.setValue(result, forKey: "isFinish")
        }
    }
    //    func toggleCheck(_ id: ObjectId) {
    //        try! realm.write {
    //            realm.add(Todom, update: <#T##Realm.UpdatePolicy#>)
    //        }
    //    }
}
