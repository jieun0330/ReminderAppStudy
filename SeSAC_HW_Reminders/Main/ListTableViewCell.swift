//
//  ListTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import UIKit
import SnapKit
import RealmSwift

class ListTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let realm = try! Realm()
    var list: Results<ReminderModel>!

//    let
    
    let repository = ToDoRepository()
    
    var check: ((Bool) -> Void)?
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        
//        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .highlighted)
        return button
    }()
    
    let todoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "?"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [checkButton, todoLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        todoLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(20)
            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.centerY.equalTo(checkButton)
            $0.height.equalTo(20)
//            $0.width.equalTo(100)
        }
    }
    
    override func configureView() {
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
    }
    
    @objc func checkButtonClicked() {
//        repository.updateComplete(list)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
