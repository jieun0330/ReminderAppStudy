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

    let realm = try! Realm()
    var list: Results<ReminderModel>!
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        return view
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        return button
    }()
    

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
        navigationItem.rightBarButtonItem = rightButton
        list = realm.objects(ReminderModel.self)
    }
    
    @objc func rightBarButtonClicked() {
        // 마감일순을 눌렀을 때 sort가 되어야되는구나 위에꺼 가져와야징
        let upcomingDate = UIAction(title: "마감일순", handler: { _ in
            self.list = self.realm.objects(ReminderModel.self).sorted(byKeyPath: "date", ascending: true)
            self.tableView.reloadData()
//            print("마감일순")
        })
        
        
        let title = UIAction(title: "제목순", handler: { _ in print("제목순") })
        let lowPriority = UIAction(title: "우선순위 낮음", handler: { _ in print("우선순위 낮음") })
        rightButton.menu = UIMenu(options: .displayInline, children: [upcomingDate, title, lowPriority])
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")!
        
        cell.textLabel?.text = list[indexPath.row].date

        return cell
    }

}
