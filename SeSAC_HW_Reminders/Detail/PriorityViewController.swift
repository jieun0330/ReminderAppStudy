//
//  PriorityViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import UIKit
import SnapKit

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
}

class PriorityViewController: BaseViewController {
    
    var segmentValue: ((String) -> Void)?
    
    lazy var segment: UISegmentedControl = {
        let control = UISegmentedControl()
        control.removeAllSegments()
        priority.allCases.enumerated().forEach { (index, section) in
            control.insertSegment(withTitle: section.title, at: index, animated: true)
        }
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
//        toDoCase.allCases.enumerated().forEach { (index, section) in
//            <#code#>
//        }

        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(priority.allCases.ind)

    }
    
    override func configureHierarchy() {
        [segment].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        segment.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(40)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        

        
//        print(segment.selectedSegmentIndex)
//        print(priority.high.rawValue)
        print(priority.RawValue.self) // Int
        
        
//        if segment.
    }
    
    @objc func segmentSelected(_ sender: UISegmentedControl) {
        
        let tag = sender.selectedSegmentIndex
//        sender.tag = priority.allCases.raw
        print(tag)
//
        
        
        if sender.selectedSegmentIndex == priority.allCases[tag].rawValue {

            segmentValue?(priority.allCases[tag].title)
            
        }
    }
    
    
//    func segmentSelected(_ sender: UISegmentedControl) {
//        if segment.selectedSegmentIndex == priority.high.rawValue {
//            print("맍는데")
//        }
//    }
}
