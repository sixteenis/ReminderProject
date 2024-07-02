//
//  ListViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit
import SnapKit
final class ListViewController: BaseViewController {
    private let mainLabel = UILabel()
    private let listTableView = UITableView()
    private let mainText = MainTitle.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNV()
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
        print(#function)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        
        return cell
    }
    
    
}
