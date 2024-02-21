//
//  PriorityViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import UIKit
import SnapKit

final class PriorityViewController: BaseViewController {
    
    var segmentValue: (([String]) -> Void)?
    
    lazy var segment: UISegmentedControl = {
        let control = UISegmentedControl()
        control.removeAllSegments()
        priority.allCases.enumerated().forEach { (index, section) in
            control.insertSegment(withTitle: section.title, at: index, animated: true)
        }
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        
        return control }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @objc func segmentSelected(_ sender: UISegmentedControl) {
        let tag = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == priority.allCases[tag].rawValue {
            segmentValue?([priority.allCases[tag].title, priority.allCases[tag].exclamationMark])
        }
    }
}
