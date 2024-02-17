//
//  ToDoViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

class NewTodoViewController: BaseViewController {
    
    let repository = ToDoRepository()
    var receivedTitle = ""
    var receivedMemo = ""
    var receivedDate = ""
    var receivedTag = ""
    var receivedSegmentValue = ["", ""]
    
    // 5. 변수 생성
    var delegate: ReloadDataDelegate?
    
    lazy var cancleButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        return button }()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        return button }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.delegate = self
        view.dataSource = self
        view.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        view.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return view }() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notificationCenter를 ViewWillAppear가 아닌 viewDidLoad에 쓰는 이유
        // 얘는 나 값 받을거야~ 설정~! 이라서
        // viewDidLoad때 설정을 뙇 처음 한번 해주는거임
        // viewWillAppear에서 설정을 해버리면 화면이 바뀔때마다 설정설정설정섲엊섲 하겠지?
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(tagReceivedNotification),
                                               name: Notification.Name(rawValue: "tagReceived"),
                                               object: nil)
        addButton.isEnabled = false
    }
    
    override func configureHierarchy() {
        [tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "새로운 할 일"
        navigationItem.rightBarButtonItem = self.addButton
        navigationItem.leftBarButtonItem = self.cancleButton
        
        // addbutton이 활성화가 돼야해
        NotificationCenter.default.addObserver(self, selector: #selector(receivedTitleTextFieldNotification), name: Notification.Name("title"), object: nil)
        
        //        print("1", receivedTitle)
        //        
        //        NotificationCenter.default.addObserver(self, selector: #selector(receivedMemoNotification), name: NSNotification.Name("memo"), object: nil)
    }
    
    //    @objc func receivedMemoNotification(notification: NSNotification) {
    //        if let value = notification.userInfo?["memo"] as? String {
    //            receivedMemo = value
    //            print("memo1", value)
    //            print("memo2", receivedMemo)
    //        }
    //    }
    
    @objc func receivedTitleTextFieldNotification(notification: NSNotification) {
        if let value = notification.userInfo?["title"] as? String {
            receivedTitle = value
            addButton.isEnabled = true
            print("2", value)
            print("2", receivedTitle)
        }
    }
    
    @objc func tagReceivedNotification(notification: NSNotification) {
        // nsnotification.userinfo에 저장된 딕셔너리 값을 가져오기 위해
        // value는 Any?값이 된다 -> 타입캐스팅을 해준다
        // String? -> 옵셔널 바인딩을 해준다
        if let value = notification.userInfo?["tagReceived"] as? String {
            // 이것도 cell에 넣어줘야하니까 변수를 만들어주자
            receivedTag = "#\(value)"
            // 이것도 reload?
            tableView.reloadData()
        }
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    // 4. 추가 버튼했을때 delegate 동작을 해줘야되니까 여기다 써줘야되는데 변수를 생성해주고 오자
    @objc func addButtonClicked() {
        let data = ReminderModel(title: receivedTitle, memo: "", date: receivedDate, tag: receivedTag, priority: receivedSegmentValue[1], complete: false)
        repository.createRecord(data)
        // 추가 버튼 후 -> 카운트업 역할
        // 6. reloadData역할을 여기서 해준다
        delegate?.reloadData()
        dismiss(animated: true)
    }
}

extension NewTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewToDoEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == NewToDoEnum.title.rawValue {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        tableView.sectionHeaderTopPadding = 1
        //        tableView.sectionHeaderHeight = 0
        
        //        indexPath.section.
        //
        //        let titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
        //        
        //        let section = NewToDoEnum.allCases[indexPath.section]
        //        print(section)
        //        switch section {
        //        case .title:
        //            titleCell.titleTextField.placeholder = section.cellTitle
        //        case .date:
        //            titleCell.titleTextField.placeholder = section.cellTitle
        //        case .tag:
        //            titleCell.titleTextField.placeholder = section.cellTitle
        //        case .priority:
        //            titleCell.titleTextField.placeholder = section.cellTitle
        //        case .image:
        //            titleCell.titleTextField.placeholder = section.cellTitle
        //        }
        //        
        //        return titleCell
        
        
        if indexPath.section == NewToDoEnum.title.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
            cell.titleTextField.placeholder = NewToDoEnum.title.cellTitle
            if indexPath.row == 1 {
                cell.titleTextField.placeholder = "메모"
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
            cell.title.text = NewToDoEnum.allCases[indexPath.section].cellTitle
            
            if indexPath.section == NewToDoEnum.date.rawValue {
                cell.receivedValue.text = receivedDate
            } else if indexPath.section == NewToDoEnum.tag.rawValue {
                cell.receivedValue.text = receivedTag
            } else if indexPath.section == NewToDoEnum.priority.rawValue {
                cell.receivedValue.text = receivedSegmentValue[0]
                
            } else {
                cell.receivedValue.text = ""
            }
            //            let section = toDoCase.allCases[indexPath.row]
            //            
            //            cell.receivedTitle.text = section.rawValue
            //            switch section {
            //            case .memo:
            //                cell.receivedTitle = moemo
            //            case .date:
            //                cell.receivedTitle = date
            //            case .tag:
            //                <#code#>
            //            case .priority:
            //                <#code#>
            //            case .image:
            //                <#code#>
            //            }
            // 5. receivedDate에 담아줬으니까 cell에 보여줄수 있게 되었어!!
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == NewToDoEnum.date.rawValue {
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            // 1️⃣ 클로저 방법
            // 4. 가져온걸 cell에다가 쓰려면 변수에 담아줘야할거같아
            vc.selectedDate = {value in
                self.receivedDate = value
                // 6. 데이터가 바꼈으니까 -> 뷰도 바껴야겠지, reload를 해주자
                tableView.reloadData()
            }
        } else if indexPath.section == NewToDoEnum.tag.rawValue {
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == NewToDoEnum.priority.rawValue {
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.segmentValue = { value in
                print(value)
                self.receivedSegmentValue = value
                tableView.reloadData()
                
            }
        }
        else {
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}
