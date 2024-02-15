//
//  RemindersViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/14/24.
//

import UIKit
import SnapKit

class RemindersViewController: BaseViewController {
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        return button
    }()
    
    let entireText: UILabel = {
        let entire = UILabel()
        entire.text = "전체"
        entire.font = UIFont.boldSystemFont(ofSize: 20)
        return entire
    }()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.backgroundColor = .systemGray6
        view.register(RemindersCollectionViewCell.self, forCellWithReuseIdentifier: RemindersCollectionViewCell.identifier)
        return view
    }()
    
    let cellImage = ["sportscourt.circle", "calendar.circle.fill", "archivebox.circle.fill", "flag.circle.fill", "checkmark.circle.fill"]
    
    lazy var leftToolBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(leftToolBarButtonClicked))
        
        return button
    }()
    
    lazy var rightToolBarButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(rightToolBarButtonClicked))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        [entireText, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        entireText.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(entireText.snp.bottom).offset(20)
            $0.height.equalTo(400)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        configureToolBar()
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func rightBarButtonItemClicked() {
        
    }
    
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
        let vc = UINavigationController(rootViewController: ToDoViewController())
        present(vc, animated: true)
    }
    
    @objc func rightToolBarButtonClicked() {
        
    }
    
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemindersCollectionViewCell.identifier, for: indexPath) as! RemindersCollectionViewCell
        
        cell.circleIcon.image = UIImage(systemName: cellImage[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
