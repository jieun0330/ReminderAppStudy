//
//  RemindersViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

// 3️⃣ delegate
// 1. 프로토콜을 만들어주자
protocol ReloadDataDelegate {
    func reloadData()
}

// 2. 채택해주자
class RemindersViewController: BaseViewController, ReloadDataDelegate{
    
    // 3. collectionView reload를 해주고싶어
    func reloadData() {
        collectionView.reloadData()
    }
    
    let repo = ToDoRepository()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        return button }()
    
    let allText: UILabel = {
        let entire = UILabel()
        entire.text = "전체"
        entire.font = UIFont.boldSystemFont(ofSize: 20)
        return entire }()
    
    var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.backgroundColor = .systemGray6
        view.register(RemindersCollectionViewCell.self, forCellWithReuseIdentifier: RemindersCollectionViewCell.identifier)
        return view }()
    
    lazy var leftToolBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(customView: customButton)
        return button }()
    
    lazy var customButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle(" 새로운 할 일", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(leftToolBarButtonClicked), for: .touchUpInside)
        return button }()
    
    lazy var rightToolBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(rightToolBarButtonClicked))
        return button }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        [allText, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        allText.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(allText.snp.bottom).offset(20)
            $0.height.equalTo(400)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem = rightBarButtonItem
        collectionView.delegate = self
        collectionView.dataSource = self
        configureToolBar()
    }
    
    @objc func rightBarButtonItemClicked() { }
    
    func configureToolBar() {
        // 버튼들 사이에 간격을 지정하기 위해서는 flexibleSpace가 필요하다
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        // ToolBar는 UINavigationController에 속해있고 기본적으로 숨겨져있어서 -> false
        self.navigationController?.isToolbarHidden = false
        // 아 중간에 넣어주라고~
        [leftToolBarButton, flexibleSpace, rightToolBarButton].forEach {
            items.append($0)
        }
        self.toolbarItems = items
    }
    
    @objc func leftToolBarButtonClicked() {
        // 7. TodoViewController로 이동하는 공간에 만들어주자
        let vc = NewTodoViewController()
        // 8. ToDoViewController안에 delegate 하는 역할을 여기서 해준다!
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func rightToolBarButtonClicked() { }
    
    // 🚨static을 써야 저 위에 쓸 수 있는건가
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

extension RemindersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellUI.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemindersCollectionViewCell.identifier, for: indexPath) as! RemindersCollectionViewCell
        // 맞다 지은아 딕셔너리는 순서가 정해져있는게 아니라서 index 접근이 안된다
        // 어떻게 하더라 -> enum으로 바꿈
        cell.circleIcon.image = UIImage(systemName: cellUI.allCases[indexPath.item].cellImage)
        cell.circleIcon.tintColor = cellUI.allCases[indexPath.item].cellColor
        cell.cellTitle.text = cellUI.allCases[indexPath.item].cellTitle
        
        switch cellUI.allCases[indexPath.row] {
        case .today:
            cell.countLabel.text = "0"
        case .schedule:
            cell.countLabel.text = "0"
        case .all:
            cell.countLabel.text = "\(repo.readRecordAllFilter().count)"
        case .flag:
            cell.countLabel.text = "0"
        case .complete:
            cell.countLabel.text = "\(repo.readRecordCompletedFilter().count)"
        }
        
        return cell        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
