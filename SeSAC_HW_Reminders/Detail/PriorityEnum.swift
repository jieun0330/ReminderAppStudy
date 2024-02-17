//
//  PriorityEnum.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/17/24.
//

import Foundation

enum priority: Int, CaseIterable {
    
    case none
    case low
    case middle
    case high
    
    var title: String {
        switch self {
        case .none:
            "없음"
        case .low:
            "낮음"
        case .middle:
            "중간"
        case .high:
            "높음"
        }
    }
    
    var exclamationMark: String {
        switch self {
        case .none:
            ""
        case .low:
            "!"
        case .middle:
            "!!"
        case .high:
            "!!!"
        }
    }
}
