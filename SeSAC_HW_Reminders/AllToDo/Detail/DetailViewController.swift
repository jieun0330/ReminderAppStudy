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
    var receivedImg = ""
    var receivedIndex: Int = 0
    var delegate: ReloadDataDelegate?
    
    lazy var cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked)).then { _ in
    }
    
    lazy var doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked)).then { _ in
    }
    
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .systemGray6
        $0.delegate = self
        $0.dataSource = self
        $0.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        $0.rowHeight = 100
    }
    
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
    
    @objc func doneButtonClicked() {
        dismiss(animated: true)
        delegate?.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        cell.titleTextField.text = list[receivedIndex].title
        cell.image.image = loadImageFromDocument(fileName: "\(list[receivedIndex].id)")

        return cell
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        repository.updateTodoTitle(list[receivedIndex], text: textField.text!)
    }
}
