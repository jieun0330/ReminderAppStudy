//
//  MemoTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class MemoTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let titleTextField: UITextField = {
        let title = UITextField()
        title.placeholder = "제목"
        title.textAlignment = .left
        return title
    }()
    
    let memoTextView: UITextView = {
        let memo = UITextView()
        memo.text = "메모"
        
        return memo
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [titleTextField, memoTextView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        titleTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        memoTextView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
