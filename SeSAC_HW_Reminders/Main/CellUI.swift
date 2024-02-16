//
//  CellUI.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import UIKit

enum cellUI: Int, CaseIterable {
    case today
    case schedule
    case all
    case flag
    case complete
    
    var cellImage: String {
        switch self {
        case .today:
            "sportscourt.circle"
        case .schedule:
            "calendar.circle.fill"
        case .all:
            "archivebox.circle.fill"
        case .flag:
            "flag.circle.fill"
        case .complete:
            "checkmark.circle.fill"
        }
    }
    
    var cellTitle: String {
        switch self {
        case .today:
            "오늘"
        case .schedule:
            "예정"
        case .all:
            "전체"
        case .flag:
            "깃발 표시"
        case .complete:
            "완료됨"
        }
    }
    
    var cellColor: UIColor {
        switch self {
        case .today:
            return .blue
        case .schedule:
            return .red
        case .all:
            return .gray
        case .flag:
            return .orange
        case .complete:
            return .gray
        }
    }
}
