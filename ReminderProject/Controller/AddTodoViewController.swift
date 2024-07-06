//
//  AddTodoViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit

import SnapKit

final class AddTodoViewController: BaseViewController {
    private let mainBoxView = UIView()
    private let mainTextView = UITextView()
    private let line = UIView()
    private let subTextView = UITextView()
    
    private let dateView = OptionAddTodoView()
    private let tagView = OptionAddTodoView()
    private let priortiView = OptionAddTodoView()
    private let imageView = OptionAddTodoView()
    
    private let todoSetList: [AddTodoTitle] = [.date,.tag,.priority,.image] // 셀 갯수
    let createModel = TodoSetModel()
    let todoRepository = TodoListRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddToDoView"), object: nil, userInfo: nil)
        setUpTextView()
    }
    // TODO: 화면을 밑으로 내려도 알람 뜨게 구현해보자!
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//            if !mainTextView.text.isEmpty && self.isMovingFromParent {
//                checkCancelOk()
//            }
//        
//        
//    }
    deinit {
        mainTextView.text = Placeholder.title
        mainTextView.textColor = Placeholder.color
        
        subTextView.text = Placeholder.subTitle
        subTextView.textColor = Placeholder.color
    }
    
    override func setUpHierarchy() {
        view.addSubview(mainBoxView)
        mainBoxView.addSubview(mainTextView)
        mainBoxView.addSubview(line)
        mainBoxView.addSubview(subTextView)
        
        view.addSubview(dateView)
        view.addSubview(tagView)
        view.addSubview(priortiView)
        view.addSubview(imageView)
        
    }
    override func setUpLayout() {
        mainBoxView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(160)
        }
        mainTextView.snp.makeConstraints { make in
            make.top.equalTo(mainBoxView.snp.top).inset(5)
            make.horizontalEdges.equalTo(mainBoxView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom)
            make.horizontalEdges.equalTo(mainBoxView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(1)
        }
        subTextView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.horizontalEdges.equalTo(mainBoxView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(110)
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(mainBoxView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        tagView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        priortiView.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(priortiView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
    }
    override func setUpView() {
        navigationItem.title = "새로운 할 일"
        let leftItem = UIBarButtonItem(title: "취소",style: .plain,  target: self, action: #selector(cancelButtonTapped))
        let rightItem = UIBarButtonItem(title: "추가",style: .plain,  target: self, action: #selector(saveButtonTapped))
        navigationItem.leftBarButtonItem = leftItem
        rightItem.tintColor = .placeholderClor
        navigationItem.rightBarButtonItem = rightItem
        
        
        mainBoxView.backgroundColor = .box
        mainBoxView.layer.cornerRadius = 15
        
        mainTextView.backgroundColor = .box
        
        line.backgroundColor = .textColor
        
        subTextView.backgroundColor = .box
    }
    private func setUpTextView() {
        mainTextView.delegate = self
        mainTextView.tag = 0
        subTextView.delegate = self
        subTextView.tag = 1
        mainTextView.text = Placeholder.title
        mainTextView.textColor = Placeholder.color
        
        subTextView.text = Placeholder.subTitle
        subTextView.textColor = Placeholder.color
        
        dateView.changeDate(type: .date)
        dateView.addTarget(self, action: #selector(dateViewTapped), for: .touchUpInside)
        tagView.changeDate(type: .tag)
        tagView.addTarget(self, action: #selector(tagViewTapped), for: .touchUpInside)
        priortiView.changeDate(type: .priority)
        priortiView.addTarget(self, action: #selector(priortiViewTapped), for: .touchUpInside)
        imageView.changeDate(type: .image)
        imageView.addTarget(self, action: #selector(imageViewTapped), for: .touchUpInside)
    }
    // MARK: - 옵션 버튼 함수 구현 부분
    @objc func dateViewTapped() {
        let vc = DateOptionViewController()
        vc.completion = {
            // TODO: date 형태 변환하기
            guard let date = $0 else {return}
            self.createModel.setdate(date)
            self.dateView.changeInputTitle(self.createModel.date)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tagViewTapped() {
        let vc = TagOptionViewController()
        vc.completion = {
            self.createModel.setTag($0)
            self.tagView.changeInputTitle($0)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func priortiViewTapped() {
        print(#function)
        let vc = PriorityOptionViewController()
        vc.completion = {
            self.createModel.setPriority($0)
            if $0 != 0 {
                self.priortiView.changeInputTitle($1)
            }else{
                self.priortiView.changeInputTitle("")
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func imageViewTapped() {
        print(#function)
        let vc = ImageOptionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - 버튼 함수 부분
    @objc func cancelButtonTapped() {
        if mainTextView.text!.isEmpty{
            dismiss(animated: true)
        }else{
            checkCancelOk()
        }
    }
    
    @objc func saveButtonTapped() {
        let todo:TodoListModel
        todo = createModel.makeModel(mainTextView.text!)
        todoRepository.createItem(todo)
        dismiss(animated: true)
    }
    
    // MARK: - 입력 되었는지 확인 (저장 버튼 활성화)
    func checkMainText(text: String) {
        if text.isEmpty { //빔
            navigationItem.rightBarButtonItem?.tintColor = .placeholderClor
            navigationItem.rightBarButtonItem?.isEnabled = false
            
        }else{ //안빔
            navigationItem.rightBarButtonItem?.tintColor = .blueColor
            navigationItem.rightBarButtonItem?.isEnabled = true
            
        }
    }
    func checkCancelOk() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        //2.
        
        let delete = UIAlertAction(title: "변경 사항 폐기", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        //3.
        alert.addAction(cancel)
        alert.addAction(delete)
        //4
        present(alert, animated: true)
    }
    
}

extension AddTodoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 && textView.textColor != Placeholder.color{
            self.checkMainText(text: textView.text)
        }
    }
    // MARK: - 누를 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.textColor == Placeholder.color{
            textView.text = nil
            textView.textColor = .textColor
        }
    }
}
