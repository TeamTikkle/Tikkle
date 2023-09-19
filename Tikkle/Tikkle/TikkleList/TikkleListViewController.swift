//
//  TikkleListPageViewController.swift
//  Tikkle
//
//  Created by Future on 2023/08/15.
//

import UIKit
import SnapKit


class TikkleListViewController: UIViewController {
    
    var dropdownView: UIView!
    var dropdownLabels: [UILabel]!
    
    //MARK: -티끌리스트매니저 모델 생성 (이제부터 이 매니저 모델을 통해 데이터를 매니징할 수 있음)
    var tikkleListManager = TikkleListManager()
    
    
    // MARK: - UI 요소
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 티끌 시트"
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .white
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .subTitleColor
        return label
    }()
    
    let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        
        // 타이틀 설정
        button.setTitle("   진행중", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .left

        // 버튼 테두리 색상 설정
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5
        
        // 버튼 배경색 설정
        button.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
 
        return button
    }()
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var createTikkleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .mainColor
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        button.layer.cornerRadius = 45 / 2
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(createTikkleButtonClick), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupDropdownView()
        
        
    }
    
    @objc func createTikkleButtonClick() {
        let vc = CreateTikkleViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTableView() {
        // 1. 셀 클래스 등록
        tableView.register(TikkleListTableViewCell.self, forCellReuseIdentifier: "TikkleListCell")
        
        // 2. 데이터 소스와 델리게이트 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        // 추가적인 테이블뷰 설정 (옵션)
        tableView.tableFooterView = UIView()  // 빈 셀에 대한 구분선 제거
    }
    func setupDropdownView() {
        dropdownView = UIView()
        dropdownView.backgroundColor = .white
        dropdownView.isHidden = true
        dropdownView.layer.cornerRadius = 5
        view.addSubview(dropdownView)
        
        dropdownLabels = ["  전체", "  진행중", "  완료"].map { text in
            let label = UILabel()
            label.text = text
            label.textColor = .black
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:))))
            return label
        }
        
        let stackView = UIStackView(arrangedSubviews: dropdownLabels)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        dropdownView.addSubview(stackView)
        
        // Constraints 설정
        dropdownView.snp.makeConstraints { make in
            make.top.equalTo(dropdownButton.snp.bottom)
            make.trailing.equalTo(view).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(dropdownView)
        }
    }
    
    func setupDropdownButton() {
        // dropdownButton을 뷰에 추가
        view.addSubview(dropdownButton)
        
        // 이후 SnapKit을 사용해 제약 조건 설정
        dropdownButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(view).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(37)
        }
        
        if let dropdownImage = UIImage(systemName: "arrowtriangle.down.fill") {
            let tintedImage = dropdownImage.withTintColor(.mainColor, renderingMode: .alwaysOriginal)
               let imageView = UIImageView(image: tintedImage)
               dropdownButton.addSubview(imageView)
               
               // UIImageView에 대한 제약 조건 설정
               imageView.snp.makeConstraints { make in
                   make.centerY.equalTo(dropdownButton)
                   make.trailing.equalTo(dropdownButton).offset(-10)
                   make.width.height.equalTo(13)
               }
           }
        
        
    
        // 버튼 액션 설정
        dropdownButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }
    
    
    
    @objc func toggleDropdown() {
        dropdownView.isHidden = !dropdownView.isHidden
    }
    
    
    @objc func handleLabelTap(_ gesture: UITapGestureRecognizer) {
        if let label = gesture.view as? UILabel {
            dropdownButton.setTitle(label.text, for: .normal)
            dropdownView.isHidden = true
        }
    }
    
    func setupUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view).offset(20)
        }
        
        setupDropdownButton()
        
        
        view.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
        
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.bottom.equalTo(view)
        }
        
        view.addSubview(createTikkleButton)
        createTikkleButton.snp.makeConstraints { make in
            make.width.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalTo(view).offset(-20)
        }
    }
    
    
}

// MARK: - UITableViewDataSource
extension TikkleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tikkleListManager.getTikkleList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TikkleListCell", for: indexPath) as! TikkleListTableViewCell
        cell.titleLabel.text = tikkleListManager[indexPath.row].title.description
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TikkleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}


