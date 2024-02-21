//
//  DetailListTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import UIKit
import SnapKit

final class DetailMyListTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let checkCircle: UIButton = {
        let check = UIButton()
        check.setImage(UIImage(systemName: "circle"), for: .normal)
        return check }()
    
    let listContents: UILabel = {
        let content = UILabel()
        return content }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [checkCircle, listContents].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        checkCircle.snp.makeConstraints {
            $0.leading.top.equalTo(contentView).offset(20)
            $0.size.equalTo(20)
        }
        
        listContents.snp.makeConstraints {
            $0.centerY.equalTo(checkCircle)
            $0.leading.equalTo(checkCircle.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView).offset(-20)
            $0.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
