//
//  ToDoCase.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import Foundation

enum NewToDoEnum: Int, CaseIterable {
    
    case title
    case date
    case tag
    case priority
    case image
    case list
    
    var cellTitle: String {
        
        switch self {
        case .title:
            "제목"
        case .date:
            "마감일"
        case .tag:
            "태그"
        case .priority:
            "우선순위"
        case .image:
            "이미지 추가"
        case .list:
            "목록"
        }
    }
}
