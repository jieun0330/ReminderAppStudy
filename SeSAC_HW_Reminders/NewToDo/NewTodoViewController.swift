//
//  ToDoViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class NewTodoViewController: BaseViewController, UITextFieldDelegate {
    
    let repository = ReminderMainRepository()
    var receivedTitle = ""
    var receivedMemo = ""
    var receivedDate = ""
    var receivedTag = ""
    var receivedSegmentValue = ["", ""]
    var receivedImage: UIImageView = UIImageView(image: UIImage(systemName: ""))
    
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
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.delegate = self
        view.dataSource = self
        view.register(NewToDoSecondTableViewCell.self, forCellReuseIdentifier: NewToDoSecondTableViewCell.identifier)
        view.register(NewToDoFirstTableViewCell.self, forCellReuseIdentifier: NewToDoFirstTableViewCell.identifier)
        return view }()
    

//    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
//        let tap = UITapGestureRecognizer()
//        tap.delegate = self
//        return tap
//    }()
    
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
//        view.addGestureRecognizer(tapGestureRecognizer)
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
//        view.backgroundColor = .systemGray6
        navigationItem.title = "새로운 할 일"
        navigationItem.rightBarButtonItem = self.addButton
        navigationItem.leftBarButtonItem = self.cancleButton
//        receivedImage.layer.cornerRadius = 5
    }
    

    /*
     NSNotification.userinfo에 저장된 딕셔너리 값을 가져오기 위해
     value는 Any?값이 된다 -> 타입캐스팅을 해준다
     String? -> 옵셔널 바인딩을 해준다
     */
    @objc func tagReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["tagReceived"] as? String {
            receivedTag = "#\(value)"
            tableView.reloadData()
        }
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        let data = ReminderMainModel(title: receivedTitle, memo: receivedMemo, date: receivedDate, tag: receivedTag, priority: receivedSegmentValue[1], complete: false, flag: false)
        repository.createRecord(data)
        
        if let image = receivedImage.image {
            saveImageToDocument(image: image, fileName: "\(data.id)")
        }
        
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
        
        if indexPath.section == NewToDoEnum.title.rawValue {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NewToDoFirstTableViewCell.identifier, for: indexPath) as! NewToDoFirstTableViewCell
            cell.titleTextField.tag = indexPath.row
            cell.titleTextField.delegate = self
            
            if indexPath.row == 0 {
                cell.titleTextField.placeholder = NewToDoEnum.title.cellTitle
                cell.titleTextField.text = receivedTitle
            }
            else {
                cell.titleTextField.placeholder = "메모"
                cell.titleTextField.text = receivedMemo
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewToDoSecondTableViewCell.identifier, for: indexPath) as! NewToDoSecondTableViewCell
            cell.title.text = NewToDoEnum.allCases[indexPath.section].cellTitle
            
            if indexPath.section == NewToDoEnum.date.rawValue {
                cell.receivedValue.text = receivedDate
            } else if indexPath.section == NewToDoEnum.tag.rawValue {
                cell.receivedValue.text = receivedTag
            } else if indexPath.section == NewToDoEnum.priority.rawValue {
                cell.receivedValue.text = receivedSegmentValue[0]
            } else if indexPath.section == NewToDoEnum.image.rawValue {
                cell.receivedImg.image = receivedImage.image
                
            }
            return cell
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        
        if textField.tag == 0 {
            receivedTitle = textField.text!
            addButton.isEnabled = true
        } else {
            receivedMemo = textField.text!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == NewToDoEnum.date.rawValue {
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
            
            vc.selectedDate = {value in
                self.receivedDate = value
                tableView.reloadData()
            }
        } else if indexPath.section == NewToDoEnum.tag.rawValue {
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == NewToDoEnum.priority.rawValue {
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.segmentValue = { value in
                self.receivedSegmentValue = value
                tableView.reloadData()
            }
        }
        else {
            let vc = UIImagePickerController()
            vc.allowsEditing = true
            vc.delegate = self
//            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//            actionSheet.addAction(UIAlertAction(title: "사진 찍기", style: .default, handler: { _ in
//                vc.sourceType = .camera
//            }))
//            actionSheet.addAction(UIAlertAction(title: "사진 보관함", style: .default, handler: { _ in
//                vc.sourceType = .photoLibrary
//            }))
            present(vc, animated: true)
            

            
            
        }
    }
    
    // 섹션 간의 간격 조정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}


//extension NewTodoViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return true
//    }
//}

extension NewTodoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            receivedImage.image = pickedImage
            tableView.reloadData()

            
        }
//        print("받아왔나")

        dismiss(animated: true)


        
    }
}
