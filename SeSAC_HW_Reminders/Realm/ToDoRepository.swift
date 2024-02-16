//
//  ToDoRepository.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import Foundation
import RealmSwift

class ToDoRepository {
    
    let realm = try! Realm()
//    print(realm.configuration.fileURL)
    
    func createRecord(_ data: ReminderModel) {
        
        do {
            try realm.write {
                realm.add(data)
                    print(realm.configuration.fileURL)

//                print("real created")
            }
        } catch {
            
        }
        

    }
    
    
}
