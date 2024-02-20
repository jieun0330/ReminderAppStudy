//
//  DetailListViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

class DetailListViewController: BaseViewController {
    
    var main: ListModel!
//    var list: List<DetailListModel>!
    
    var listTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 30)
//        title.text = main.title
        return title
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
//        view.layer.borderColor = UIColor.red.cgColor
//        view.layer.borderWidth = 1
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        list = main.detail

    }
    
    override func configureHierarchy() {
        [listTitle, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        listTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(listTitle.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
    }

    override func configureView() {
        view.backgroundColor = .white
//        navigationItem.title = main.title
//        print(main.title)
        listTitle.text = main.title
    }

}
