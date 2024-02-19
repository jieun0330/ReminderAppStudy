//
//  DetailViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit

class DetailViewController: BaseViewController {
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        return button
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    override func configureHierarchy() {
//        <#code#>
//    }
//    
//    override func configureConstraints() {
//        <#code#>
//    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "세부사항"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() {
        
    }

}
