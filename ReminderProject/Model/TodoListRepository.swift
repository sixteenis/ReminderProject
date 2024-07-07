//
//  TodoListRepository.swift
//  ReminderProject
//
//  Created by 박성민 on 7/4/24.
//

import Foundation
import RealmSwift

final class TodoListRepository {
    private let realm = try! Realm()
    private let today = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "yyyy.MM.dd(E)"
        let today = format.string(from: Date())
        return today
    }()
    func createItem(_ data: TodoListModel) {
        print(realm.configuration.fileURL!)
        try! realm.write {
            realm.add(data)
        }
    }
//    func fetchToday() -> Results<TodoListModel> {
//        let data = realm.objects(TodoListModel.self)
//        let result = data.where {
//            return $0.date == today
//        }
//        return result
//    }
//    func fetchNotyet() -> Results<TodoListModel> {
//            let data = realm.objects(TodoListModel.self)
//            let result = data.where {
//                $0.date > today
//            }
//            return result
//        }
    func fetchAll() -> Results<TodoListModel> {
        let data = realm.objects(TodoListModel.self)
        return data
    }
    
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
