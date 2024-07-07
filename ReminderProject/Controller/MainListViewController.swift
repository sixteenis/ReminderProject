//
//  MainListViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit
import SnapKit
final class MainListViewController: BaseViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private let bottomView = UIView()
    private let newlistButton = UIButton(type: .custom)
    
    let list: [MainList] = MainList.allCases
    let repository = TodoListRepository()
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 30
        layout.itemSize = CGSize(width: width / 2, height: width / 4) //셀
        layout.scrollDirection = .vertical // 가로, 세로 스크롤 설정
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //repository.fetchToday()
    }
    override func setUpHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(bottomView)
        bottomView.addSubview(newlistButton)
    }
    override func setUpLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
        bottomView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        newlistButton.snp.makeConstraints { make in
            make.leading.equalTo(bottomView.safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(bottomView.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        navigationItem.title = "전체"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        
        bottomView.backgroundColor = .background
        
        newlistButton.setTitle("새로운 할일", for: .normal)
        newlistButton.titleLabel?.font = .systemFont(ofSize: 18)
        newlistButton.setTitleColor(.blueColor, for: .normal)
        newlistButton.setImage(.plus, for: .normal)
        newlistButton.imageEdgeInsets = .init(top: 0, left: -10, bottom: 0, right: 0)
        newlistButton.addTarget(self, action: #selector(newlistButtonTapped), for: .touchUpInside)
    }
    @objc func buttonTapped() {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func newlistButtonTapped() {
        let vc = AddTodoViewController()
        let nv = UINavigationController(rootViewController: vc)
        present(nv, animated: true)
    }

}


extension MainListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        let data = list[indexPath.item]
        cell.changeView(type: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
