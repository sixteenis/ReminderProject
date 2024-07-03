//
//  MainListViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/3/24.
//

import UIKit
import SnapKit
final class MainListViewController: BaseViewController {
    // MARK: - 내일 뷰 구현....
    let testButton = UIButton() // 임시 버튼
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUpHierarchy() {
        view.addSubview(testButton)
    }
    override func setUpLayout() {
        testButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(70)
        }
    }
    override func setUpView() {
        testButton.setTitle("뷰 이동", for: .normal)
        testButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    @objc func buttonTapped() {
        let vc = ListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
