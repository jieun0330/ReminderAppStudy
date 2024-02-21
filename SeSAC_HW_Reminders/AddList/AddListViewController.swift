//
//  AddListViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

class AddListViewController: BaseViewController {
    
    let toDoRepository = ReminderMainRepository()
    let listRepository = MyListRepository()
    var delegate: ReloadDataDelegate?
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        return button
    }()
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        return button
    }()
    
    let listNameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let listIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "list.bullet.circle.fill")
        return icon
    }()
    
    let listNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "목록 이름"
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 15
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [listNameView].forEach {
            view.addSubview($0)
        }
        
        [listIcon, listNameTextField].forEach {
            listNameView.addSubview($0)
        }
        
    }
    
    override func configureConstraints() {
        listNameView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(220)
        }
        
        listIcon.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.centerX.equalTo(view)
            $0.top.equalToSuperview().offset(20)
        }
        
        listNameTextField.snp.makeConstraints {
            $0.top.equalTo(listIcon.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
    }
    
    override func configureView() {
        navigationItem.title = "새로운 목록"
        view.backgroundColor = .systemGray6
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        
        
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func doneButtonClicked() {
        let data = ListModel(title: listNameTextField.text!, registDate: Date())
        
        listRepository.createRecord(data)
        dismiss(animated: true)
        
        delegate?.reloadData()
        // RemindersViewController에 있는 TableView가 reload 되야해용
        // 1. doneButton 클릭
        // 2. RemindersViewController로 이동
        // 3. RemindersViewController - TableView Reload
        
    }


}
