//
//  ToDoCase.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import Foundation

enum toDoCase: String, CaseIterable {
    case memo = "메모"
    case date = "마감일"
    case tag = "태그"
    case priority = "우선순위"
    case image = "이미지 추천"
    
    var index: Int {
        switch self {
        case .memo:
            return 0
        case .date:
            return 1
        case .tag:
            return 2
        case .priority:
            return 3
        case .image:
            return 4
        }
    }
}
