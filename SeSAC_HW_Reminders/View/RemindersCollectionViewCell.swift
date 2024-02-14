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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        [circleIcon].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {

        circleIcon.snp.makeConstraints {
            $0.leading.top.equalTo(contentView).inset(10)
            $0.size.equalTo(30)
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
