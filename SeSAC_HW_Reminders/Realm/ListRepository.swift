//
//  ListRepository.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import Foundation
import RealmSwift

class ListRepository {
    
    // open a realm
    let realm = try! Realm()
    
    // "C"RUD
    func createRecord(_ data: ListModel) {
        do {
            try realm.write {
                realm.add(data)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    // C"R"UD
    func readList() -> Results<ListModel> {
        return realm.objects(ListModel.self)
    }
    
    
}
