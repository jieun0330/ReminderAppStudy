//
//  ToDoTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class ToDoTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let title: UILabel = {
        let todo = UILabel()
        todo.textColor = .white
        return todo
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [title].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
//            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .lightGray
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
