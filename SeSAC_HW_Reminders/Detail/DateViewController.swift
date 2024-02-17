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
        return picker }()
    
    // 2. 클로저 생성
    var selectedDate: ((String) -> Void)?
    
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
        datePicker.addTarget(self, action: #selector(datePickerClicked), for: .valueChanged)
    }
    
    @objc func datePickerClicked() {
        let date = self.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let strDate = dateFormatter.string(from: date)
        // 1. pick한 날짜를 TodoViewController로 보내줘야돼, 그럼 여긴 함수 안이니까 바깥으로 꺼내주려면 closure를 써야겠지??
        // 3. 클로저 생성 완료, 그럼 TodoViewController에서 접근할 수 있겠지?
        selectedDate?(strDate)
    }
}
