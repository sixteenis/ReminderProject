//
//  MainListViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit
import SnapKit
final class MainListViewController: BaseViewController {
    private let mainTitle = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let list: [MainList] = [.today,.notYet,.all,.flag,.complet]
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
    }
    override func setUpHierarchy() {
        view.addSubview(mainTitle)
        view.addSubview(collectionView)
    }
    override func setUpLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(mainTitle.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpView() {
        mainTitle.text = "전체"
        mainTitle.font = .boldSystemFont(ofSize: 40)
        mainTitle.textColor = .darkGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    @objc func buttonTapped() {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
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
    
    
}
