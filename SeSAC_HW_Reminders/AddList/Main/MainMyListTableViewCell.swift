//
//  MyListTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import UIKit

final class MainMyListTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let icon: UIButton = {
        let icon = UIButton()
        icon.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        return icon }()
    
    let title: UILabel = {
        let text = UILabel()
        return text }()
    
    let listCount: UILabel = {
        let count = UILabel()
        count.textColor = .lightGray
        return count }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [icon, title, listCount, moreButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).inset(10)
            $0.size.equalTo(20)
        }
        
        title.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(icon.snp.trailing).offset(10)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).inset(20)
        }
        
        listCount.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(moreButton.snp.leading).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
