//
//  PriorityViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import UIKit
import SnapKit

class PriorityViewController: BaseViewController {
    
    let segment: UISegmentedControl = {
        let control = UISegmentedControl()
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [segment].forEach {
            view.addSubview($0)
        }
    }
    
//    override func configureConstraints() {
//        <#code#>
//    }
    
    override func configureView() {
        view.backgroundColor = .white
    }

}
