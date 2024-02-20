//
//  DetailViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit
import SnapKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    var list: Results<ReminderModel>!
    var repository = ToDoRepository()
    var receivedTitle = ""

    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        return button
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        return button
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .systemGray6
        view.delegate = self
        view.dataSource = self
        view.register(DetailFirstTableViewCell.self, forCellReuseIdentifier: DetailFirstTableViewCell.identifier)
        view.register(DetailSecondTableViewCell.self, forCellReuseIdentifier: DetailSecondTableViewCell.identifier)
        return view
    }()

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
//        view.backgroundColor = .white
        navigationItem.title = "세부사항"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() {
        
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
        
//        if indexPath.section == NewToDoEnum.title.rawValue {
//            let cell = tableView.dequeueReusableCell(withIdentifier: DetailFirstTableViewCell.identifier, for: indexPath) as! DetailFirstTableViewCell
        
        
        print(list[indexPath.row].title)
            
//            if indexPath.row == 0 {
//                
//                cell.textField.text = "여기 왜 터져? "
//
//
//
//            } else{
//                cell.textField.placeholder = "메모"
//            }

//            return cell
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailSecondTableViewCell.identifier, for: indexPath) as! DetailSecondTableViewCell
        
        
//        print(list)
//        cell.icon.setImage(UIImage(named: list), for: <#T##UIControl.State#>)
//                cell.image.image = UIImage(named: "\(list[indexPath.row].id)")

//        cell.title.text = list[indexPath.row].title
//
        
//        cell.image.image =
//        cell.image.image = loadImageFromDocument(fileName: "\(list[indexPath.row].id)")

           
//            switch NewToDoEnum.allCases[indexPath.row] {
//                
//            case .title:
//                cell.title.text = ""
//            case .date:
//                cell.icon.setImage(UIImage(systemName: "calendar"), for: .normal)
//                cell.title.text = "날짜"
//            case .tag:
//                cell.icon.setImage(UIImage(systemName: "tag.square.fill"), for: .normal)
//                cell.title.text = "태그"
//            case .priority:
//                cell.icon.setImage(UIImage(systemName: "exclamationmark.square.fill"), for: .normal)
//                cell.title.text = "우선순위"
//            case .image:
//                cell.icon.setImage(UIImage(systemName: "photo.fill"), for: .normal)
//                cell.title.text = "이미지"
//            }

            
            
            return cell
//            
//            
//            
//        }
//        

    }
}
