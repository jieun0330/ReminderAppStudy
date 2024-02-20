//
//  DetailListTableViewCell.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/20/24.
//

import UIKit

class DetailListTableViewCell: BaseTableViewCell{
    
    var main: ListModel!
    
    let listTitle: UILabel = {
        let title = UILabel()
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
//    override func configureHierarchy() {
//        <#code#>
//    }
//    
//    override func configureConstraints() {
//        <#code#>
//    }
    
    override func configureView() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
