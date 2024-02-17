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
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        return button }()
    
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "!!!"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBlue
//        label.numberOfLines = 0
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "키보드 구매"
//        label.numberOfLines = 0
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "서브타이틀"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
//        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
//        label.text = "?"
        return label }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemBlue
        label.text = "#쇼핑"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [checkButton, priorityLabel, mainLabel, subtitleLabel, dateLabel, tagLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(10)
            $0.size.equalTo(20)
        }
        
        priorityLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(10)
//            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.centerY.equalTo(checkButton)
            $0.height.equalTo(20)
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(priorityLabel.snp.trailing).offset(5)
//            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.centerY.equalTo(checkButton)
            $0.height.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(priorityLabel.snp.leading)
            $0.top.equalTo(priorityLabel.snp.bottom).offset(5)
//            $0.height.equalTo(15)
            $0.height.greaterThanOrEqualTo(15)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(priorityLabel.snp.leading)
//            $0.trailing.equalTo(contentView.snp.trailing).inset(20)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(3)
//            $0.height.equalTo(20)
            $0.height.greaterThanOrEqualTo(15)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(3)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(3)
            $0.height.equalTo(15)

        }
        

    }
    
    override func configureView() {
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
    }
    
    @objc func checkButtonClicked() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
