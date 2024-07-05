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
    private let listTableView = UITableView()
    private let todoRepository = TodoListRepository()
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
        list = todoRepository.fetchAll()
        listTableView.reloadData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    override func setUpHierarchy() {
        view.addSubview(listTableView)
    }
    override func setUpLayout() {
        listTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        navigationItem.title = "전체"
        
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        listTableView.backgroundColor = .background
        listTableView.rowHeight = UITableView.automaticDimension
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
        let nv = UINavigationController(rootViewController: vc)
        present(nv, animated: true)
    }
    // MARK: - 이전뷰에 이벤트 받기
    @objc func dismissAddTodoNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.list = self.todoRepository.fetchAll()
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
            print(data)
            cell.changeView(data: data)
            cell.checkCloser = { [weak self] in
                guard let self = self else { return }
                let item = self.list[indexPath.row]
                todoRepository.changeItem(item)
                cell.changeView(data: item)
                
//                tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
            return cell
        }
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let remove = UIContextualAction(style: .normal, title: "삭제") { action, view, completion in
                
                self.todoRepository.deleteItem(self.list[indexPath.row])
                DispatchQueue.main.async {
                    self.list = self.todoRepository.fetchAll()
                    tableView.reloadData()
                }
                
                
            }
            remove.backgroundColor = .systemRed
            remove.image = UIImage(systemName: "trash")
            
            return UISwipeActionsConfiguration(actions: [remove])
        }
        
        
    }
