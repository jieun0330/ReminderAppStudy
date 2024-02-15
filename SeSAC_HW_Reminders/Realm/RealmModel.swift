//
//  RealmModel.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import Foundation
import RealmSwift

class ReminderModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String
    @Persisted var date: String
    @Persisted var tag: String
    @Persisted var priority: String
    
    convenience init(id: ObjectId, title: String, memo: String, date: String, tag: String, priority: String) {
        self.init() // 이거 없으면 오류 뜨는데 내가 알아서 만들게~~~~ 하는 의미라서 이거 넣으면 오류 싹~ 사라져여~
        self.id = id
        self.title = title
        self.memo = memo
        self.date = date
        self.tag = tag
        self.priority = priority
    }
}
