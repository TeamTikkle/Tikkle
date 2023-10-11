//
//  TikkleListPageViewController.swift
//  Tikkle
//
//  Created by Future on 2023/08/15.
//

import UIKit
import SnapKit


class TikkleListViewController: UIViewController {
    
    var tikkle: Tikkle?
    var selectedTikkleSheet: TikkleSheet?
    
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
        button.setTitle("  진행중", for: .normal)
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
        updateCountLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupDropdownView()
        
        // 티끌 리스트 데이터 생성
        tikkleListManager.makeTikkleListDatas()
        
    }
    
    @objc func createTikkleButtonClick() {
        let vc = CreateTikkleViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateCountLabel() {
        let count = tikkleListManager.getTikkleList().count
        countLabel.text = "\(count) 장"
    }

    
    func setupTableView() {
        tableView.register(TikkleListTableViewCell.self, forCellReuseIdentifier: "TikkleListCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        
        tableView.separatorColor = .mainColor.withAlphaComponent(0.3)
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
        view.addSubview(dropdownButton)
        
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
            
            imageView.snp.makeConstraints { make in
                make.centerY.equalTo(dropdownButton)
                make.trailing.equalTo(dropdownButton).offset(-10)
                make.width.height.equalTo(13)
            }
        }
        
        
        
        // 버튼 액션 설정
        dropdownButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }
    
    func navigateToTikkleSheetViewController(for tikkleSheet: TikkleSheet) {
        let tikkleSheetVC = TikkleSheetViewController()
        tikkleSheetVC.tikkle = tikkleSheet
        navigationController?.pushViewController(tikkleSheetVC, animated: true)
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
        view.addSubview(countLabel)
        view.addSubview(tableView)
        view.addSubview(createTikkleButton)
        setupDropdownButton()
        
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view).offset(20)
        }
        
        
        countLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
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
        
        let tikkleSheet = tikkleListManager[indexPath.row]
        cell.titleLabel.text = tikkleSheet.title
        cell.squareImageView.image = tikkleSheet.image
        cell.setDateLabel(createDate: tikkleSheet.createDate) 
        
        //percentLabel 설정
        let completedCount = tikkleListManager[indexPath.row].stampList.filter { $0.isCompletion }.count
        let totalCount = tikkleListManager[indexPath.row].stampList.count
        
        // percentLabel : 퍼센트 값 계산
        let percentage: Double
        if totalCount != 0 { // 나눌 값이 0이면 안돼!
            percentage = (Double(completedCount) / Double(totalCount)) * 100.0
        } else {
            percentage = 0
        }
        
        //percentLabel에 설정
        cell.percentLabel.text = "\(Int(percentage))%"
        
        
        for (index, tikkle) in tikkleSheet.stampList.prefix(10).enumerated() {
            if index < cell.circleViews.count {
                if tikkle.isCompletion {
                    cell.circleViews[index].backgroundColor = .white
                } else {
                    cell.circleViews[index].backgroundColor = UIColor.white.withAlphaComponent(0.1)
                }
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TikkleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTikkle = tikkleListManager[indexPath.row]
        navigateToTikkleSheetViewController(for: selectedTikkle)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}


