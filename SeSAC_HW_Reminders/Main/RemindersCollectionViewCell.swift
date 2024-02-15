//
//  RemindersCollectionViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class RemindersCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let circleIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "calendar.circle.fill")
        return icon
    }()
    
    let cellTitle: UILabel = {
        let title = UILabel()
        title.text = "전체"
        title.font = UIFont.systemFont(ofSize: 12)
        return title
    }()
    
    let count: UILabel = {
        let number = UILabel()
        number.text = "0"
        return number
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        [circleIcon, cellTitle, count].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        circleIcon.snp.makeConstraints {
            $0.leading.top.equalTo(contentView).inset(10)
            $0.size.equalTo(30)
        }
        cellTitle.snp.makeConstraints {
            $0.centerX.equalTo(circleIcon.snp.centerX)
            $0.top.equalTo(circleIcon.snp.bottom).offset(5)
            $0.height.equalTo(10)
        }
        
        count.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(10)
            $0.top.equalTo(contentView).offset(15)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
