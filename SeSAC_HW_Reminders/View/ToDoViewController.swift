//
//  ToDoViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class ToDoViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        
//        view.style = .plain
        view.delegate = self
        view.dataSource = self
        view.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        return view
    }()

    
    let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        return bar
    }()
    
    var titleList: [String] = ["마감일", "태그", "우선 순위", "이미지 추가"]
    
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
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(70)
        }
    }
    
    override func configureView() {
        
        view.backgroundColor = .white
//        self.navigationItem.title = "새로운 미리 알림"
//        navigationbar
        navigationItem.title = "새로운 미리 알림"
//        navigationController?.navigationBar.lef
//        navigationItem.rightBarButtonItem?.title = "?"
//        self.navigationBar.topItem?.title = "새로운 미리 알림"
//        navigationController?.navigationBar.topItem?.title = "새로운 미리 알림"
        
//        navigationController?.navigationItem.leftBarButtonItem?.title = "취소"
//        navigationController?.navigationItem.rightBarButtonItem?.title = "추가"
//        view.layer.style = .none
    }
    

}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    

    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ""
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 2
//        } else {
            return 1
//        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        
        cell.title.text = "마감일"
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UINavigationController(rootViewController: DateViewController())
        present(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    

}
