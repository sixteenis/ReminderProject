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
    
    func createItem(_ data: TodoListModel) {
        print(realm.configuration.fileURL!)
        try! realm.write {
            realm.add(data)
        }
    }
    
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
            //data.setValue(data.isCheck.toggle(), forKey: "isCheck")
            let result = !data.isCheck
            data.setValue(result, forKey: "isCheck")
        }
    }
//    func toggleCheck(_ id: ObjectId) {
//        try! realm.write {
//            realm.add(Todom, update: <#T##Realm.UpdatePolicy#>)
//        }
//    }
}
