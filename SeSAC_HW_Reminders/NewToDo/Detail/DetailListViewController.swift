//
//  DetailListViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/22/24.
//

import UIKit
import SnapKit

class DetailListViewController: BaseViewController {
    
    let tableView = UITableView().then { _ in
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [tableView].forEach {
            view.addSubview($0)
        }

    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func configureView() {
        navigationItem.title = "목록"
        view.backgroundColor = .systemGray6
    }

}
