//
//  Protocol.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import Foundation

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

// 새로운 할일 화면: 추가 버튼 클릭 시 -> 메인화면 reload delegate
protocol ReloadDataDelegate {
    func reloadData()
}
