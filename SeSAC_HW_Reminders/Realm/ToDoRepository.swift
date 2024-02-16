//
//  ToDoRepository.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import Foundation
import RealmSwift

class ToDoRepository {
    
    // open a realm
    let realm = try! Realm()
    
    // "C"RUD
    func createRecord(_ data: ReminderModel) {
        
        do {
            try realm.write {
                realm.add(data)
//                    print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    // C"R"UD
    func readRecordFilter() -> Results<ReminderModel> {
        return realm.objects(ReminderModel.self)
    }
    
    // CR"U"D
    
    // CRU"D"
//    func deleteRecord() {
//        realm.delete(<#T##object: ObjectBase##ObjectBase#>)
//    }
    
}
