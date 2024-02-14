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
