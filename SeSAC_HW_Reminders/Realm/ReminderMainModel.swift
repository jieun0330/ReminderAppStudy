//
//  RealmModel.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import Foundation
import RealmSwift
//
//class ListModel: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var title: String
//    @Persisted var registDate: Date
//    
//    convenience init(title: String, registDate: Date) {
//        self.init()
//        self.title = title
//        self.registDate = registDate
//    }
//}

class ReminderMainModel: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String?
    @Persisted var memo: String?
    @Persisted var date: String
    @Persisted var tag: String
    @Persisted var priority: String?
    @Persisted var complete: Bool
    @Persisted var flag: Bool
    
    convenience init(title: String, memo: String, date: String, tag: String, priority: String, complete: Bool, flag: Bool) {
        self.init() // 이거 없으면 오류 뜨는데 내가 알아서 만들게~~~~ 하는 의미라서 이거 넣으면 오류 싹~ 사라져여~
        self.title = title
        self.memo = memo
        self.date = date
        self.tag = tag
        self.priority = priority
        self.complete = complete
        self.flag = flag
    }
}
