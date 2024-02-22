//
//  ListViewController.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/15/24.
//

import UIKit
import SnapKit
import RealmSwift
import DGCharts

final class AllToDoViewController: BaseViewController, ReloadDataDelegate {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    let repository = ReminderMainRepository()
    var list: Results<ReminderMainModel>!
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundImage = UIImage() // searchBar 모양이 못생기긴했는데 흰색 뒷배경을 없애려면 UIImage()를 줘야한다
        return search
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        return button
    }()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(AllToDoTableViewCell.self, forCellReuseIdentifier: AllToDoTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = repository.readRecordAllFilter()
        
    }
    
    override func configureHierarchy() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
//        chartView.snp.makeConstraints {
//            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//            $0.height.equalTo(350)
//        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
        tableView.rowHeight = 80
        
//        let entry = [BarChartDataEntry(x: 1, y: 800),
//                     BarChartDataEntry(x: 2, y: 400),
//                     BarChartDataEntry(x: 3, y: 180)]
//        let set = BarChartDataSet(entries: entry, label: "우선순위별")
//        set.stackLabels = ["!", "!!", "!!!"]
//        chartView.data = BarChartData(dataSet: set)
    }
    
    @objc func rightBarButtonClicked() {
        
        let upcomingDate = UIAction(title: "마감일순", handler: { _ in
            self.list = self.repository.readRecordAllFilter().sorted(byKeyPath: "date", ascending: true)
            self.tableView.reloadData()
        })
        
        let title = UIAction(title: "제목순", handler: { _ in
            self.list = self.repository.readRecordAllFilter().sorted(byKeyPath: "title", ascending: true)
            self.tableView.reloadData()
        })
        
        let lowPriority = UIAction(title: "우선순위 낮음", handler: { _ in
            self.list = self.repository.readRecordAllFilter().sorted(byKeyPath: "priority", ascending: true)
            self.tableView.reloadData()
        })
        rightBarButton.menu = UIMenu(options: .displayInline, children: [upcomingDate, title, lowPriority])
    }
}

extension AllToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AllToDoTableViewCell.identifier, for: indexPath) as! AllToDoTableViewCell
        
        cell.mainLabel.text = list[indexPath.row].title
        cell.subtitleLabel.text = list[indexPath.row].memo
        cell.dateLabel.text = list[indexPath.row].date
        cell.selectionStyle = .none
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        cell.priorityLabel.text = list[indexPath.row].priority
        cell.tagLabel.text = list[indexPath.row].tag
        cell.image.image = loadImageFromDocument(fileName: "\(list[indexPath.row].id)")
        cell.flagLabel.setImage(list[indexPath.row].flag == true ? UIImage(systemName: "flag.fill") : UIImage(systemName: ""), for: .normal)
        cell.flagLabel.tintColor = .orange
        
        return cell
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        repository.updateComplete(list[sender.tag])
        sleep(1)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.receivedIndex = indexPath.row
        vc.delegate = self

        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.repository.deleteRecord(self.list[indexPath.row])
            print("삭제 클릭")
            success(true)
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        let flag = UIContextualAction(style: .normal, title: "깃발") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.repository.updateFlag(self.list[indexPath.row])
            tableView.reloadData()
        }
        flag.backgroundColor = .orange
        
        let detail = UIContextualAction(style: .normal, title: "세부사항") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("세부사항 클릭")
            success(true)
        }
        detail.backgroundColor = .lightGray
        
        return UISwipeActionsConfiguration(actions: [delete, flag, detail])
    }
}
