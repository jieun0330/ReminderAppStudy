//
//  ListTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import UIKit
import SnapKit

final class AllToDoTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        return button
    }()
    
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBlue
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemBlue
        return label
    }()
    
    let image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let flagLabel: UIButton = {
        let flag = UIButton()
        return flag
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [checkButton, priorityLabel, mainLabel, subtitleLabel, dateLabel, tagLabel, image, flagLabel].forEach {
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
            $0.centerY.equalTo(checkButton)
            $0.height.equalTo(20)
        }
        
        mainLabel.snp.makeConstraints {
            $0.leading.equalTo(priorityLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(checkButton)
            $0.height.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(priorityLabel.snp.leading)
            $0.top.equalTo(priorityLabel.snp.bottom).offset(5)
            $0.height.greaterThanOrEqualTo(15)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(priorityLabel.snp.leading)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(3)
            $0.height.greaterThanOrEqualTo(15)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(3)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(3)
            $0.height.equalTo(15)
        }
        
        image.snp.makeConstraints {
            $0.trailing.equalTo(flagLabel.snp.leading).offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.top.equalTo(mainLabel.snp.top)
            $0.size.equalTo(40)
        }
        
        flagLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(checkButton)
            $0.size.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
