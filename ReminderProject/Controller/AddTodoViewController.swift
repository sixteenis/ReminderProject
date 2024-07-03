//
//  AddTodoViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift
final class AddTodoViewController: BaseViewController {
    private let cancelButton = UIButton()
    private let navTitle = UILabel()
    private let addButton = UIButton()
    
    private let mainBoxView = UIView()
    private let mainTextView = UITextView()
    private let line = UIView()
    private let subTextView = UITextView()
    
    private let dateView = OptionAddTodoView()
    private let tagView = OptionAddTodoView()
    private let priortiView = OptionAddTodoView()
    private let imageView = OptionAddTodoView()
    
    private let todoSetList: [AddTodoTitle] = [.date,.tag,.priority,.image] // 셀 갯수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainTextView.text = Placeholder.title
        mainTextView.textColor = Placeholder.color
        
        subTextView.text = Placeholder.subTitle
        subTextView.textColor = Placeholder.color
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddToDoView"), object: nil, userInfo: nil)
    }
    
    override func setUpHierarchy() {
        view.addSubview(cancelButton)
        view.addSubview(navTitle)
        view.addSubview(addButton)
        
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
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(45)
        }
        navTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(45)
        }
        mainBoxView.snp.makeConstraints { make in
            make.top.equalTo(navTitle.snp.bottom).offset(15)
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
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.blueColor, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        navTitle.text = "새로운 할 일"
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.placeholderClor, for: .normal)
        addButton.isEnabled = false
        addButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
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
        tagView.changeDate(type: .tag)
        priortiView.changeDate(type: .priority)
        imageView.changeDate(type: .image)
    }
    
    // MARK: - 버튼 함수 부분
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        let realm = try! Realm()
        let todo:TodoListModel
        if subTextView.textColor! == .placeholderClor {
            todo = TodoListModel(title: mainTextView.text, memo: nil, tag: nil, date: Date())
        }else{
            todo = TodoListModel(title: mainTextView.text, memo: subTextView.text, tag: nil, date: Date())
        }
        try! realm.write {
            realm.add(todo)
        }
        dismiss(animated: true)
    }
    
    // MARK: - 입력 되었는지 확인 (저장 버튼 활성화)
    func checkMainText(text: String) {
        if text.isEmpty { //빔
            addButton.setTitleColor(.placeholderClor, for: .normal)
            addButton.isEnabled = false
        }else{ //안빔
            addButton.setTitleColor(.blueColor, for: .normal)
            addButton.isEnabled = true
        }
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
