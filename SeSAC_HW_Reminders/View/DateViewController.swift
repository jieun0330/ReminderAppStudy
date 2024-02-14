//
//  DateViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class DateViewController: BaseViewController {
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        return picker
    }()
    
//    let dateView: UIView = {
//        let view = UIView()
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [datePicker].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(500)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "세부사항"
    }

}
