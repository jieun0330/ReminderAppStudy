//
//  MemoTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class NewToDoFirstTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    lazy var titleTextField: UITextField = {
        let title = UITextField()
        title.textAlignment = .left
        return title }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [titleTextField].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        titleTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
