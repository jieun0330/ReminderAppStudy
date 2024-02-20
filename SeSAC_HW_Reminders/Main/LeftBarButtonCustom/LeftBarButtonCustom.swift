//
//  CustomView.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/17/24.
//

import UIKit
import SnapKit

class LeftBarButtonCustom: BaseView {
    
    let customButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle(" 새로운 할 일", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button }()
    
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
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
