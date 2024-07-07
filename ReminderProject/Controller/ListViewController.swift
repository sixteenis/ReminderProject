//
//  ListViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift
import Toast

final class ListViewController: BaseViewController {
    private let listTableView = UITableView()
    private let todoRepository = TodoListRepository()
    private var list: Results<TodoListModel>! {
        didSet {
            self.listTableView.reloadData()
        }
    }

    private var mainList: Results<TodoListModel>!
    var listType: MainList?
    var completion: (() -> ())?
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
        switch listType {
        case .today:
            list = todoRepository.fetchToday()
        case .notYet:
            list = todoRepository.fetchNotyet()
        case .all:
            list = todoRepository.fetchAll()
        case .flag:
            list = todoRepository.fetchFlag()
        case .complet:
            list = todoRepository.fetchFinish()
        case nil:
            list = todoRepository.fetchToday()
        }
        mainList = list
        listTableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("11231231")
        todoRepository.allFetch()
        completion?()
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
        listTableView.rowHeight = 120
        // TODO: 셀의 값의 형태에 따라 셀의 높이가 변화하게 구현해보자!
        //listTableView.rowHeight = UITableView.automaticDimension
    }
    private func setUpNV() {
        let item1 = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),style: .plain,  target: self, action: #selector(filterButtonTapped))
        navigationItem.setRightBarButton(item1, animated: true)
    }
    
    
    // MARK: - 버튼 함수 부분
    @objc func filterButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "우선 순위 낮음", style: .default) { _ in
            self.list = self.mainList.where {
                $0.priority == 1
            }
        }
        
        let option2 = UIAlertAction(title: "우선 순위 중간", style: .default) { _ in
            self.list = self.mainList.where {
                $0.priority == 2
            }
        }
        let option3 = UIAlertAction(title: "우선 순위 높음", style: .default) { _ in
            self.list = self.mainList.where {
                $0.priority == 3
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        alertController.addAction(option3)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
            popoverController.permittedArrowDirections = .up
        }
        
        present(alertController, animated: true)
            
        
    }
//    @objc func plusButtonTapped() {
//        let vc = AddTodoViewController()
//        let nv = UINavigationController(rootViewController: vc)
//        present(nv, animated: true)
//    }
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
            // TODO: 버튼 누르면 그게 없어져서 팅기는 문제 해결하기~~~~~
            cell.checkCloser = { [weak self] in
                guard let self = self else { return }
                let item = self.list[indexPath.row]
                todoRepository.changeItem(item)
                cell.changeView(data: item)
                tableView.reloadData()
                //tableView.reloadRows(at: [indexPath], with: .automatic)
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
            let flag = UIContextualAction(style: .normal, title: "깃발") { action, view, completion in
                
                self.todoRepository.changeflag(self.list[indexPath.row])
                DispatchQueue.main.async {
                    //self.list = self.todoRepository.fetchAll()
                    self.view.makeToast("깃발 설정 완료!")
                    tableView.reloadData()
                }
                
                
            }
            flag.backgroundColor = .systemYellow
            flag.image = UIImage(systemName: self.list[indexPath.row].isFlag ? "flag.fill" : "flag")
            
            return UISwipeActionsConfiguration(actions: [remove,flag])
        }
        
        
    }
