//
//  TikkleListPageViewController.swift
//  Tikkle
//
//  Created by Future on 2023/08/15.
//

import UIKit
import SnapKit


class TikkleListPageViewController: UIViewController {
    
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
        label.text = "3개"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .subTitleColor
        return label
    }()
    
    let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  진행중", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        // 버튼 크기 설정
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(37)
        }
        
        // 버튼 테두리 색상 설정
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupDropdownView()
        

    }
    
    @objc func createTikkleButtonClick() {
          let vc = CreateTikklePageViewController()
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
        
        // 버튼 테두리 색상 설정
        dropdownButton.layer.borderColor = UIColor.green.cgColor
        dropdownButton.layer.borderWidth = 1.0
        dropdownButton.layer.cornerRadius = 5
        
        // 버튼 배경색 설정
        dropdownButton.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
        // 버튼 액션 설정
        dropdownButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        
        if let dropdownImage = UIImage(named: "dropdown") {
            dropdownButton.setImage(dropdownImage, for: .normal)
        }
        
        // 텍스트와 이미지의 위치를 조정
        dropdownButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
 
        dropdownButton.contentHorizontalAlignment = .left
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
extension TikkleListPageViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TikkleListCell", for: indexPath) as! TikkleListTableViewCell


        return cell
    }
}

// MARK: - UITableViewDelegate
extension TikkleListPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

}


//class TikkleListPageViewController: UIViewController {
//
//    let margin: CGFloat = 16
//
//
//    //MARK: -티끌리스트매니저 모델 생성 (이제부터 이 매니저 모델을 통해 데이터를 매니징할 수 있음)
//    var tikkleListManager = TikkleListManager()
//
//
//    //MARK: -TikkleListPage ViewController 스토리보드 요소들 연결
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var mainLabel: UILabel!
//    @IBOutlet weak var subLabel: UILabel!
//    @IBOutlet weak var createTikkleButton: UIButton!
//
//
//    //MARK: -리스트가 비어 있을 시에 안내 문구 표시하는 라벨
//    let square: UIView = {
//        let squareView = UIView()
//        squareView.backgroundColor = UIColor.white.withAlphaComponent(0.05) // 5% 투명도
//        squareView.translatesAutoresizingMaskIntoConstraints = false
//        return squareView
//    }()
//
//    let emptyStateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "생성하기를 통해\n티끌시트를 만들어보세요"
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//
//
//    //MARK: - TikkleListPage ViewController 앱 실행될 때 처음 실행되는 곳
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        seupTableView()
//        setUI()
//        emptyGreetingUI()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//        emptyGreetingUI()
//    }
//
//    //MARK: -TikkleListPage ViewController viewDidLoad 정리 함수들 모음
//
//    //테이블뷰 세팅 함수. 위의 viewDidLoad 깔끔하게 사용 위함.
//    func seupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    //비어있을 때 실행하는 안내문구 라벨 함수
//    func emptyGreetingUI() {
//        // 리스트가 비어 있을 경우 안내 UI 보여주기
//        if tikkleListManager.getTikkleList().isEmpty {
//
//            view.addSubview(square)
//            square.addSubview(emptyStateLabel)
//
//            NSLayoutConstraint.activate([
//                // square의 leading, trailing 설정
//                square.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
//                square.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
//
//                // square의 top을 createButton의 bottom에서부터 간격을 주게 함
//                square.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: margin),
//
//                // square의 bottom을 safeArea를 통해 탭바와 겹치지 않게 함
//                square.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
//
//                // label을 square 내부 중앙에 위치
//                emptyStateLabel.centerXAnchor.constraint(equalTo: square.centerXAnchor),
//                emptyStateLabel.centerYAnchor.constraint(equalTo: square.centerYAnchor),
//                emptyStateLabel.widthAnchor.constraint(lessThanOrEqualTo: square.widthAnchor, multiplier: 0.9)
//            ])
//        } else {
//            square.removeFromSuperview()
//            emptyStateLabel.removeFromSuperview()
//        }
//
//    }
//
//    //UI 세팅 함수.위의 viewDidLoad 깔끔하게 사용 위함.
//    func setUI() {
//
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.systemFont(ofSize: 16, weight: .bold), // 굵기 설정
//            .foregroundColor: UIColor.black
//        ]
//        let attributedText = NSAttributedString(string: "+ 생성하기", attributes: attributes)
//        createTikkleButton.setAttributedTitle(attributedText, for: .normal)
//        createTikkleButton.backgroundColor = UIColor.mainColor
//        createTikkleButton.layer.cornerRadius = 17
//        createTikkleButton.addTarget(self, action: #selector(createTikkleButtonClick), for: .touchUpInside)
//
//        view.backgroundColor = .black
//
//        //메인라벨과 서브라벨 세팅
//        mainLabel.text = "나의 Tikkle 모음"
//        subLabel.text = "티끌 모아 태산 !"
//        mainLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//        subLabel.font = UIFont.systemFont(ofSize: 15, weight: .black)
//        subLabel.textColor = UIColor.subTitleColor
//    }
//
//    @objc func createTikkleButtonClick() {
//        let vc = CreateTikklePageViewController()
//        vc.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
////MARK: -테이블 뷰 행을 탭할 때 실행
//extension TikkleListPageViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "TikklePage", bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: "TikklePageViewController") as? TikklePageViewController else { return }
//        vc.tikkle = tikkleListManager[indexPath.item]
//
//
//        if tikkleListManager.getTikkleList().isEmpty {
//            emptyGreetingUI()
//        }
//
//
//
//        //MARK: 스토리보드 삭제
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//
//
////MARK: -테이블 뷰 사용시 필수 구현해야 하는 메소드
//extension TikkleListPageViewController: UITableViewDataSource {
//    //TikkleListPage 테이블뷰 셀 개수
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return tikkleListManager.getTikkleList().count
//
//    }
//
//    //셀에 데이터 연결하기
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TikkleListTableViewCell
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 8 // 행간 설정
//
//
//
//        //titleLabel---------------------------------------------------------------------
//        cell.titleLabel.font = .systemFont(ofSize: 24)
//        cell.titleLabel.text = tikkleListManager[indexPath.row].title.description
//
//        // 공개 비공개 함깨 버튼 스택뷰 비우기
//        cell.edgeStackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
//
//        //isSharedProjectButton------------------------------------------------------------
//        if tikkleListManager[indexPath.row].isSharedProject {
//            let togetherButton =  CustomButton.makeTogetherButton()
//            togetherButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//            togetherButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
//            cell.edgeStackView.addArrangedSubview(togetherButton)
//        }
//
//
//        //percentLabel---------------------------------------------------------------------
//        //isCompletion이 true인 Stamp의 개수
//        let completedCount = tikkleListManager[indexPath.row].stampList.filter { $0.isCompletion }.count
//        let totalCount = tikkleListManager[indexPath.row].stampList.count
//
//        // percentLabel : 퍼센트 값 계산
//        let percentage: Double
//        if totalCount != 0 { // 나눌 값이 0이면 안돼!
//            percentage = (Double(completedCount) / Double(totalCount)) * 100.0
//        } else {
//            percentage = 0
//        }
//
//        //percentLabel에 설정
//        cell.percentLabel.text = "\(Int(percentage))%"
//
//
//        //tikkleImage---------------------------------------------------------------------
//        cell.tikkleImage.image = tikkleListManager[indexPath.row].image
//        cell.tikkleImage.contentMode = .scaleAspectFill //이미지 채우는 방식
//
//        //percentage가 100%일 때, 이미지 어둡게 변하도록
//        if percentage == 100 {
//            cell.tikkleImage.image = tikkleListManager[indexPath.row].image
//            cell.tikkleImage.addoverlay()
//
//            // 100%일 때 tikkleDoneSticker 이미지를 추가
//            let stickerImageViewTag = 1002
//            if cell.tikkleImage.viewWithTag(stickerImageViewTag) == nil {
//                let stickerImageView = UIImageView(image: UIImage(named: "tikkleDoneSticker"))
//                stickerImageView.contentMode = .scaleAspectFit
//                stickerImageView.tag = stickerImageViewTag  // 스티커 이미지 뷰를 식별하기 위한 tag
//                stickerImageView.translatesAutoresizingMaskIntoConstraints = false
//                cell.tikkleImage.addSubview(stickerImageView)
//
//                // 제약 조건 추가. 스티커 이미지 중앙에 배치
//                NSLayoutConstraint.activate([
//                    stickerImageView.centerXAnchor.constraint(equalTo: cell.tikkleImage.centerXAnchor),
//                    stickerImageView.centerYAnchor.constraint(equalTo: cell.tikkleImage.centerYAnchor),
//                    stickerImageView.widthAnchor.constraint(equalToConstant: 100),  // 원하는 크기로 조정
//                    stickerImageView.heightAnchor.constraint(equalToConstant: 100)  // 원하는 크기로 조정
//                ])
//            }
//        } else {
//            let overlayTag = 1001
//            if let existingOverlay = cell.tikkleImage.viewWithTag(overlayTag) {
//                existingOverlay.removeFromSuperview()
//            }
//            // 이미지가 100%가 아닐 경우, 기존에 추가된 스티커 이미지 뷰를 제거
//            if let stickerView = cell.tikkleImage.viewWithTag(1002) {
//                stickerView.removeFromSuperview()
//            }
//        }
//
//
//        //graphImage-----------------------------------------------------------------------
//        //위에서 계산한 퍼센티지에 따라 이미지 변경
//        var imageName: String
//        switch percentage {
//        case 0..<10:
//            imageName = "graph0"
//        case 10..<20:
//            imageName = "graph1"
//        case 20..<30:
//            imageName = "graph2"
//        case 30..<40:
//            imageName = "graph3"
//        case 40..<50:
//            imageName = "graph4"
//        case 50..<60:
//            imageName = "graph5"
//        case 60..<70:
//            imageName = "graph6"
//        case 70..<80:
//            imageName = "graph7"
//        case 80..<90:
//            imageName = "graph8"
//        case 90..<100:
//            imageName = "graph9"
//        case 100:
//            imageName = "graph10"
//        default:
//            imageName = "graph0" // 예외 상황
//            print("graphImage Error")
//        }
//
//        //graphImage에 설정
//        cell.graphImage.image = UIImage(named: imageName)
//
//        return cell
//    }
//}
//
//
//extension UIView {
//    func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.7) {
//        let overlayTag = 1001
//        if let existingOverlay = self.viewWithTag(overlayTag) {
//            existingOverlay.removeFromSuperview()
//        }
//
//        let overlay = UIView()
//        overlay.tag = overlayTag
//        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        overlay.frame = bounds
//        overlay.backgroundColor = color
//        overlay.alpha = alpha
//        insertSubview(overlay, at: 0)
//    }
//}

