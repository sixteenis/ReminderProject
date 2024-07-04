//
//  AddTodoViewController.swift
//  ReminderProject
//
//  Created by 박성민 on 7/2/24.
//

import UIKit

import SnapKit

final class AddTodoViewController: BaseViewController {
    // TODO: 네비 연결해서 위에 탭바 네비로 코드 다시 작성하기
    //옵션 설정에 들갔다가 나오면 메인 설정들이 초기화되는 문제 해결하기....
    //풀스크린으로 동작하기, 값 저장해놓기? 그외는 머가있지>?
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
    
    var date: Date?
    var tag: String?
    var priorty: Int?
    var image: String?
    
    let todoRepository = TodoListRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        NotificationCenter.default.post(name: NSNotification.Name("DismissAddToDoView"), object: nil, userInfo: nil)
    }
    deinit {
        mainTextView.text = Placeholder.title
        mainTextView.textColor = Placeholder.color

        subTextView.text = Placeholder.subTitle
        subTextView.textColor = Placeholder.color
        
        date = nil
        tag = nil
        priorty = nil
        image = nil
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
            self.date = $0
            guard let date = self.date else {return}
            self.dateView.changeInputTitle(date.formatted())
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tagViewTapped() {
        let vc = TagOptionViewController()
        vc.completion = {
            self.tag = $0
            self.tagView.changeInputTitle($0)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func priortiViewTapped() {
        print(#function)
        let vc = PriorityOptionViewController()
        vc.completion = {
            self.priorty = $0
            self.priortiView.changeInputTitle($1)
            
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
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        let todo:TodoListModel
        if subTextView.textColor! == .placeholderClor {
            todo = TodoListModel(title: mainTextView.text, memo: nil, tag: self.tag, date: self.date, priority: self.priorty)
        }else{
            todo = TodoListModel(title: mainTextView.text, memo: subTextView.text, tag: self.tag, date: self.date, priority: self.priorty)
        }
        todoRepository.createItem(todo)
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
