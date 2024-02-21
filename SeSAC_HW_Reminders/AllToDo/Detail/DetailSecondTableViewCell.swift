//
//  DetailSecondTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit
import SnapKit

final class DetailSecondTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let icon: UIButton = {
        let icon = UIButton()
        return icon }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark")
        return image }()
    
    let title: UILabel = {
        let text = UILabel()
        text.textColor = .black
        return text }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [icon, image, title].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        image.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        title.snp.makeConstraints {
            $0.centerY.equalTo(icon)
            $0.leading.equalTo(icon.snp.trailing).offset(5)
            $0.height.equalTo(20)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
