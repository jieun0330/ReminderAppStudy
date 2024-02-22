//
//  RemindersViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

final class MainRemindersViewController: BaseViewController {
    
    let toDoRepository = ReminderMainRepository()
    var toDolist: Results<ReminderMainModel>!
    let listRepository = MyListRepository()
    var myList: Results<ListModel>!

    let allText = UILabel().then {
        $0.text = "전체"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.backgroundColor = .systemGray6
        $0.register(MainRemindersCollectionViewCell.self, forCellWithReuseIdentifier: MainRemindersCollectionViewCell.identifier)
    }
    
    let myListText: UILabel = {
        let myList = UILabel()
        myList.text = "나의 목록"
        myList.font = UIFont.boldSystemFont(ofSize: 20)
        return myList
    }()
    
    lazy var leftCalendarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(leftCalendarButtonClicked))
        return button
    }()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        return button
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(MainMyListTableViewCell.self, forCellReuseIdentifier: MainMyListTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 50
        view.backgroundColor = .systemGray6
        return view
    }()
    
    lazy var leftToolBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(customView: customButton)
        return button
    }()
    
    lazy var customButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle(" 새로운 할 일", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(leftToolBarButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var rightToolBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(rightToolBarButtonClicked))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myList = listRepository.readList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    override func configureHierarchy() {
        [allText, collectionView, myListText, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        allText.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(allText.snp.bottom).offset(20)
            $0.height.equalTo(300)
        }
        
        myListText.snp.makeConstraints {
            $0.leading.equalTo(allText.snp.leading)
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(myListText.snp.bottom).offset(20)
            $0.height.equalTo(330)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        configureToolBar()
    }
    
    @objc private func leftCalendarButtonClicked() {
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func rightBarButtonItemClicked() { }
    
    /*
     UIToolBar
     1. 버튼들 사이에 간격을 지정하기 위해서는 flexibleSpace가 필요하다
     2. ToolBar는 UINavigationController에 속해있고 기본적으로 숨겨져있어서 -> false
     3. 버튼 사이 space를 주고싶다면 중간에 넣어준다
     */
    private func configureToolBar() {
        navigationItem.leftBarButtonItem = leftCalendarButton
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        self.navigationController?.isToolbarHidden = false
        [leftToolBarButton, flexibleSpace, rightToolBarButton].forEach {
            items.append($0)
        }
        self.toolbarItems = items
    }
    
    @objc private func leftToolBarButtonClicked() {
        // 추가 버튼 클릭 시 메인화면 reload delegate
        let vc = NewTodoViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        // nav.delegate = self를 하면 NewToDoViewController가 아닌 NavigationController에 delegate가 입혀진다(?)
        present(nav, animated: true)
    }
    
    @objc private func rightToolBarButtonClicked() {
        let vc = AddListViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 3 - 40)
        layout.minimumLineSpacing = spacing // 셀 좌우 간격
        layout.minimumInteritemSpacing = spacing // 셀 상하 간격
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}

extension MainRemindersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellUI.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRemindersCollectionViewCell.identifier, for: indexPath) as! MainRemindersCollectionViewCell
        // 딕셔너리는 순서가 정해져있는게 아니라서 index 접근이 안된다 -> enum으로 수정
        cell.circleIcon.image = UIImage(systemName: cellUI.allCases[indexPath.item].cellImage)
        cell.circleIcon.tintColor = cellUI.allCases[indexPath.item].cellColor
        cell.cellTitle.text = cellUI.allCases[indexPath.item].cellTitle
        
        switch cellUI.allCases[indexPath.row] {
        case .today:
            cell.countLabel.text = "\(toDoRepository.todayScheduleFilter().count)"
        case .schedule:
            cell.countLabel.text = "\(toDoRepository.beScheduleFilter().count)"
        case .all:
            cell.countLabel.text = "\(toDoRepository.readRecordAllFilter().count)"
        case .flag:
            cell.countLabel.text = "\(toDoRepository.flagFilter().count)"
        case .complete:
            cell.countLabel.text = "\(toDoRepository.readRecordCompletedFilter().count)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = AllToDoViewController()
        
        switch cellUI.allCases[indexPath.item] {
        case .today:
            vc.list = toDoRepository.todayScheduleFilter()
        case .schedule:
            vc.list = toDoRepository.beScheduleFilter()
        case .all:
            vc.list = toDoRepository.readRecordAllFilter()
        case .flag:
            vc.list = toDoRepository.flagFilter()
        case .complete:
            vc.list = toDoRepository.readRecordCompletedFilter()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainRemindersViewController: ReloadDataDelegate {
    
    // 추가 버튼 클릭 시 메인화면 reload delegate
    func reloadData() {
        collectionView.reloadData()
        tableView.reloadData()
    }
}

extension MainRemindersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainMyListTableViewCell.identifier, for: indexPath) as! MainMyListTableViewCell
        cell.title.text = myList[indexPath.row].title
        cell.listCount.text = "\(myList[indexPath.row].detail.count)"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMyListViewController()
        vc.main = myList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
