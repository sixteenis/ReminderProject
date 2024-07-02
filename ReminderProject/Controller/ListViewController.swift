//
//  ListViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift

final class ListViewController: BaseViewController {
    private let mainLabel = UILabel()
    private let listTableView = UITableView()
    private let mainText = MainTitle.all
    private let realm = try! Realm()
    private var list: Results<TodoListModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.dismissAddTodoNotification(_:)),
            name: NSNotification.Name("DismissAddToDoView"),
            object: nil
        )
        setUpNV()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list = realm.objects(TodoListModel.self)
        listTableView.reloadData()
    }
    override func setUpHierarchy() {
        view.addSubview(mainLabel)
        view.addSubview(listTableView)
    }
    override func setUpLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(60)
        }
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        mainLabel.text = mainText.rawValue
        mainLabel.textColor = mainText.color
        mainLabel.font = mainText.font
        
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        listTableView.backgroundColor = .white
        listTableView.rowHeight = 120
    }
    private func setUpNV() {
        let item1 = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),style: .plain,  target: self, action: #selector(filterButtonTapped))
        let item2 = UIBarButtonItem(image: UIImage(systemName: "plus"),style: .plain,  target: self, action: #selector(plusButtonTapped))
        navigationItem.setRightBarButtonItems([item1,item2], animated: true)
    }
    
    
    // MARK: - 버튼 함수 부분
    @objc func filterButtonTapped() {
        print(#function)
    }
    @objc func plusButtonTapped() {
        let vc = AddTodoViewController()
        present(vc, animated: true)
    }
    // MARK: - 이전뷰에 이벤트 받기
    @objc func dismissAddTodoNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
}
    
    extension ListViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return list.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
            let data = list[indexPath.row]
            cell.changeView(data: data)
            cell.checkCloser = { [weak self] in
                guard let self = self else { return }
                try! realm.write{
                    
                    self.realm.delete(self.list[indexPath.row])
                    
                    tableView.reloadData()
                }
                
            }
            return cell
        }
        
        
    }
