//
//  DetailListViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

class DetailMyListViewController: BaseViewController {

    var main: ListModel!
    var listRepository = MyListRepository()
    var list: Results<DetailListModel>!
//    var list: List<DetailListModel>!
    
    let listTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 30)
//        title.text = main.title
        return title
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let textField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .systemGray6
        return textfield
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 50
        view.register(DetailMyListTableViewCell.self, forCellReuseIdentifier: DetailMyListTableViewCell.identifier)
//        view.layer.borderColor = UIColor.red.cgColor
//        view.layer.borderWidth = 1
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        list = main.detail

    }
    
    override func configureHierarchy() {
        [listTitle, textField, saveButton, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        listTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(listTitle.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.trailing.equalTo(saveButton.snp.leading).offset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(textField)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
    }

    override func configureView() {
        view.backgroundColor = .white
//        navigationItem.title = main.title
//        print(main.title)
        listTitle.text = main.title
    }
    
    @objc func saveButtonClicked() {
        
        let data = DetailListModel(title: textField.text!, registDate: Date())
        listRepository.createDetailList(main: main, data: data)
        textField.text = ""
        tableView.reloadData()
        
    }

}

extension DetailMyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return main.detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailMyListTableViewCell.identifier, for: indexPath) as! DetailMyListTableViewCell
        
        cell.listContents.text = main.detail[indexPath.row].title
        
        
        return cell
    }
    
    
}
