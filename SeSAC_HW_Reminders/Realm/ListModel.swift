//
//  ListModel.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import Foundation
import RealmSwift

class ListModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var registDate: Date
    @Persisted var detail: List<DetailListModel>
    
    convenience init(title: String, registDate: Date) {
        self.init()
        self.title = title
        self.registDate = registDate
    }
}

class DetailListModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var registDate: Date
    
    convenience init(title: String, registDate: Date) {
        self.init()
        self.title = title
        self.registDate = registDate
    }
}
