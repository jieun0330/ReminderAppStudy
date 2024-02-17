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
//        view.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
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
        
        list = repository.readRecordFilter()
    }
    
    @objc func rightBarButtonClicked() {
        // 마감일순을 눌렀을 때 sort가 되어야되는구나 위에꺼 가져와야징
        let upcomingDate = UIAction(title: "마감일순", handler: { _ in
            self.list = self.repository.readRecordFilter().sorted(byKeyPath: "date", ascending: true)
            self.tableView.reloadData()
        })
        
        let title = UIAction(title: "제목순", handler: { _ in print("제목순") })
        let lowPriority = UIAction(title: "우선순위 낮음", handler: { _ in print("우선순위 낮음") })
        rightBarButton.menu = UIMenu(options: .displayInline, children: [upcomingDate, title, lowPriority])
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        cell.todoLabel.text = list[indexPath.row].date

        cell.selectionStyle = .none
        
//        let tag = cell.checkButton.tag
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)


        return cell
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        repository.updateComplete(list[sender.tag])
        tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        repository.updateComplete(list[indexPath.row])
//        tableView.reloadData()
//    }


}
