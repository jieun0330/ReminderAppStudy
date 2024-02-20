//
//  DetailTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit
import SnapKit

class DetailFirstTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let textField: UITextField = {
        let text = UITextField()
        text.textAlignment = .left
        return text
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [textField].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        textField.snp.makeConstraints {
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
