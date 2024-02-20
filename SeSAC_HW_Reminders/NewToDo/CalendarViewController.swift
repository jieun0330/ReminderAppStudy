//
//  CalendarViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarViewController: BaseViewController {
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [calendar].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        calendar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(300)

        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
    }
}
