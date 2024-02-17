//
//  ToDoTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class ToDoTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    var title: UILabel = {
        let todo = UILabel()
        todo.textColor = .white
        return todo }()
    
    let receivedTitle: UILabel = {
        let title = UILabel()
        title.text = ""
        return title }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        return button }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [title, receivedTitle, moreButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        receivedTitle.snp.makeConstraints {
            $0.trailing.equalTo(moreButton.snp.leading).offset(-20)
            $0.top.equalTo(title.snp.top)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
