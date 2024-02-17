//
//  CustomView.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/17/24.
//

import UIKit
import SnapKit

class CustomView: BaseView {
    
    //    let customView: UIView = {
    //        let view = UIView()
    //
    //        return view
    //    }()
    //
    let customButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle(" 새로운 할 일", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }()

//    let customLabel: UILabel = {
//        let label = UILabel()
//        label.text = "새로운 할 일"
//        return label
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        [customButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureConstraints() {
        customButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
//            $0.width.equalTo(200)
        }
    }
    
    override func configureView() {
//        superview?.layer.borderColor = UIColor.red.cgColor
//        superview?.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
