//
//  ToDoViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

class ToDoViewController: BaseViewController {

    let repository = ToDoRepository()
    
//    var count = 0
    // 2. countup이라는 클로저를 만들어줬어
//    var countUp: ((Int) -> Void)?
        
    var receivedDate = ""
    var receivedTextField = ""
    
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
        view.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        return view }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notificationCenter를 ViewWillAppear가 아닌 viewDidLoad에 쓰는 이유
        // 얘는 나 값 받을거야~ 설정~! 이라서
        // viewDidLoad때 설정을 뙇 처음 한번 해주는거임
        // viewWillAppear에서 설정을 해버리면 화면이 바뀔때마다 설정설정설정섲엊섲 하겠지?
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(tagReceivedNotification),
                                               name: Notification.Name(rawValue: "TextFieldReceived"),
                                               object: nil)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//    
//    }
    
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
    }
    
    @objc func tagReceivedNotification(notification: NSNotification) {
        // nsnotification.userinfo에 저장된 딕셔너리 값을 가져오기 위해
        // value는 Any?값이 된다 -> 타입캐스팅을 해준다
        // String? -> 옵셔널 바인딩을 해준다
        if let value = notification.userInfo?["textField"] as? String {
            // 이것도 cell에 넣어줘야하니까 변수를 만들어주자
            receivedTextField = value
            // 이것도 reload?
            tableView.reloadData()
        }
    }
    
    @objc func addButtonClicked() {
        
        let data = ReminderModel(title: "", memo: "", date: receivedDate, tag: receivedTextField, priority: "")
        
        repository.createRecord(data)
        
        
        
        // 1. 추가 버튼을 누르면 더해진 숫자가 메인뷰에 보여졌으면 좋겠어
        // 이것도 함수 안에 있으니까 클로저로 만들어줘야겠지?

        // 3. 만든 클로저를 여기에다가 넣어줘볼까
//        countUp()
        
        
        dismiss(animated: true)
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == toDoCase.memo.index {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as! MemoTableViewCell
            cell.titleTextField.placeholder = "제목"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
            cell.title.text = toDoCase.allCases[indexPath.section-1].rawValue
            
            if indexPath.section == toDoCase.date.index {
                cell.receivedTitle.text = receivedDate
            } else if indexPath.section == toDoCase.tag.index {
                cell.receivedTitle.text = receivedTextField
            } else {
                
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
        
        if indexPath.section == toDoCase.date.index {
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            // 1️⃣ 클로저 방법
            // 4. 가져온걸 cell에다가 쓰려면 변수에 담아줘야할거같아
            vc.selectedDate = {value in
                self.receivedDate = value
                // 6. 데이터가 바꼈으니까 -> 뷰도 바껴야겠지, reload를 해주자
//                tableView.reloadData()
            }
        } else if indexPath.section == toDoCase.tag.index {
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        }
        else {
            
        }
    }
}
