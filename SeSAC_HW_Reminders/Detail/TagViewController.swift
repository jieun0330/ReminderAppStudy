//
//  TagViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import UIKit
import SnapKit

class TagViewController: BaseViewController {
    
    //    let tagBox: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .lightGray
    //        return view
    //    }()
    //    
    //    let tagWord: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("#ㅎㅎ", for: .normal)
    //        button.backgroundColor = .systemBlue
    //        return button
    //    }()
    
    lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "새로운 태그 추가..."
        field.delegate = self
        field.backgroundColor = .lightGray
        return field }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        [textField].forEach {
            view.addSubview($0)
        }
        
        //        [tagWord].forEach {
        //            tagBox.addSubview($0)
        //        }
        
    }
    
    override func configureConstraints() {
        
        //        tagBox.snp.makeConstraints {
        //            $0.horizontalEdges.equalToSuperview().inset(20)
        //            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        //            $0.height.equalTo(50)
        //        }
        //        
        //        tagWord.snp.makeConstraints {
        //            $0.leading.equalToSuperview().inset(10)
        //            $0.centerY.equalToSuperview()
        //            
        //            $0.height.equalTo(30)
        //        }
        
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            //            $0.top.equalTo(tagBox.snp.bottom).offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(40)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "태그"
    }
}

extension TagViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 2️⃣ NotificationCenter 방법
        // 1. 텍스트필드에 입력값을 다 마치면 notificationCenter 통해서 값을 전달해줄거니까 우선 저장해보자
        NotificationCenter.default.post(name: Notification.Name("tagReceived"),
                                        object: nil,
                                        userInfo: ["tagReceived": textField.text!])
        // 1. 텍스트필드에 값의 입력을 마치면
    }
}
