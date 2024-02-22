//
//  DetailSecondTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit
import SnapKit
import RealmSwift

final class DetailTableViewCell: BaseTableViewCell, ReusableProtocol {

    var list: Results<ReminderMainModel>!
    var repository = ReminderMainRepository()
    
    lazy var titleTextField: UITextField = {
        let text = UITextField()
        return text
    }()
    
    let image = UIImageView().then {
        $0.image = UIImage(systemName: "pencil")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [titleTextField, image].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.leading.equalTo(contentView).offset(20)
            $0.height.equalTo(20)
        }
        
        image.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.top.equalTo(titleTextField.snp.top)
            $0.leading.equalTo(titleTextField.snp.trailing).offset(50)
            $0.size.equalTo(50)
        }
        
//        $0.trailing.equalTo(flagLabel.snp.leading).offset(-10)
//        $0.top.equalToSuperview().offset(10)
//        $0.top.equalTo(mainLabel.snp.top)
//        $0.size.equalTo(40)
        
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        list = repository.readRecordAllFilter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
