//
//  ToDoTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

final class NewToDoSecondTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let title: UILabel = {
        let todo = UILabel()
        todo.textColor = .black
        return todo }()
    
    let receivedValue: UILabel = {
        let title = UILabel()
        title.text = ""
        return title }()
    
    let receivedImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 5
        return img } ()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .lightGray
        return button }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [title, receivedValue, receivedImg, moreButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        receivedValue.snp.makeConstraints {
            $0.trailing.equalTo(moreButton.snp.leading).offset(-20)
            $0.top.equalTo(title.snp.top)
        }
        
        receivedImg.snp.makeConstraints {
            $0.trailing.equalTo(moreButton.snp.leading).offset(-20)
            $0.centerY.equalTo(title)
            $0.size.equalTo(30)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
