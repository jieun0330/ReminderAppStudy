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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.delegate = self
        view.dataSource = self
        view.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        view.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        return view
    }()
        
    var receivedDate = "받아온 날짜"
    
    var memoList: [String] = ["제목", "메모"]
    var todoList: [String] = ["마감일", "태그", "우선 순위", "이미지 추가"]
    
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
        view.backgroundColor = .white
        navigationItem.title = "새로운 할 일"
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as! MemoTableViewCell
            cell.titleTextField.placeholder = "제목"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
            // 5. receivedDate에 담아줬으니까 cell에 보여줄수 있게 되었어!!
            cell.receivedTitle.text = receivedDate
        
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            // 4. 가져온걸 cell에다가 쓰려면 변수에 담아줘야할거같아
            vc.selectedDate = {value in
                self.receivedDate = value
                // 6. 데이터가 바꼈으니까 -> 뷰도 바껴야겠지, reload를 해주자
                tableView.reloadData()
            }

            
        } else {
            
        }
    }
}
