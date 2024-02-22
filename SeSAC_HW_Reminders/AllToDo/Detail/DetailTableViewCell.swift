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
//        text.delegate = self
        
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [titleTextField].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        titleTextField.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(10)
            $0.height.equalTo(20)
        }
        
        //        image.snp.makeConstraints {
        //            $0.leading.equalTo(title.snp.leading)
        //            $0.top.equalTo(title.snp.bottom).offset(10)
        //            $0.trailing.equalTo(contentView.snp.trailing).offset(-10)
        //            $0.height.equalTo(150)
        //        }
        
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        list = repository.readRecordAllFilter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension DetailTableViewCell: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        
//        repository.updateTodoTitle(list[0], text: textField.text!)
        

//        print("list", list)
//        print("1번")
//        print("repository", repository.updateTodoTitle(list[0], text: textField.text!))
//        print("all", repository.readRecordAllFilter())
        
//    }
//}
