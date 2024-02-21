//
//  DetailViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit
import SnapKit
import RealmSwift

final class DetailViewController: BaseViewController {
    
    var list: Results<ReminderMainModel>!
    var repository = ReminderMainRepository()
    var receivedTitle = ""
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        return button }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        return button }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .systemGray6
        view.delegate = self
        view.dataSource = self
        view.register(DetailFirstTableViewCell.self, forCellReuseIdentifier: DetailFirstTableViewCell.identifier)
        view.register(DetailSecondTableViewCell.self, forCellReuseIdentifier: DetailSecondTableViewCell.identifier)
        return view }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = repository.readRecordAllFilter()
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
        navigationItem.title = "세부사항"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() { }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailSecondTableViewCell.identifier, for: indexPath) as! DetailSecondTableViewCell
        
        print(receivedTitle)
        
//        print(cell.title.text)
//        print(list[indexPath.row].title)
        
        cell.title.text = receivedTitle
//        print(list[indexPath.row].title)
//        print(indexPath)
//        cell.icon.text = list[indexPath.row].priority
//        print(list[indexPath.row].priority)
        
        return cell
    }
}
