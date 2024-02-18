//
//  ListViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import UIKit
import SnapKit
import RealmSwift

class ListViewController: BaseViewController {
    
    let repository = ToDoRepository()
    var list: Results<ReminderModel>!
    
    lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        return button}()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return view }()
    
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
        navigationItem.rightBarButtonItem = rightBarButton
        list = repository.readRecordAllFilter()
        tableView.rowHeight = 80
        //        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    @objc func rightBarButtonClicked() {
        
        let upcomingDate = UIAction(title: "마감일순", handler: { _ in
            self.list = self.repository.readRecordAllFilter().sorted(byKeyPath: "date", ascending: true)
            self.tableView.reloadData()
        })
        
        let title = UIAction(title: "제목순", handler: { _ in
            self.list = self.repository.readRecordAllFilter().sorted(byKeyPath: "title", ascending: true)
            self.tableView.reloadData()
        })
        
        let lowPriority = UIAction(title: "우선순위 낮음", handler: { _ in
            self.list = self.repository.readRecordAllFilter().sorted(byKeyPath: "priority", ascending: true)
            self.tableView.reloadData()
        })
        rightBarButton.menu = UIMenu(options: .displayInline, children: [upcomingDate, title, lowPriority])
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        cell.mainLabel.text = list[indexPath.row].title
        cell.subtitleLabel.text = list[indexPath.row].memo
        cell.dateLabel.text = list[indexPath.row].date
        cell.selectionStyle = .none
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        cell.priorityLabel.text = list[indexPath.row].priority
        cell.tagLabel.text = list[indexPath.row].tag
        
        return cell
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        repository.updateComplete(list[sender.tag])
        sleep(1)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.repository.deleteRecord(self.list[indexPath.row])
            print("삭제 클릭")
            success(true)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        let flag = UIContextualAction(style: .normal, title: "깃발") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("깃발 클릭")
            success(true)
        }
        flag.backgroundColor = .orange
        
        let detail = UIContextualAction(style: .normal, title: "세부사항") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("세부사항 클릭")
            success(true)
        }
        detail.backgroundColor = .lightGray
        
        return UISwipeActionsConfiguration(actions: [delete, flag, detail])
    }
}
