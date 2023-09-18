//
//  CreateTikklePageViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit
import SnapKit

class CreateTikklePageViewController: UIViewController {
    
    private var mainScrollView: UIScrollView = UIScrollView()
    private var photoImageView: UIImageView = UIImageView(image: UIImage(named: "addphoto"))
    private let challengeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "도전명"
        label.textColor = .white
        return label
    }()
    private var challengeNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "설명"
        label.textColor = .white
        return label
    }()
    private var infoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 17, weight: .bold)
        textView.textColor = .white
        textView.backgroundColor = .darkGray
        return textView
    }()
    private var tikkleNameLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "티끌명"
        label.textColor = .white
        return label
    }()
    private var tikkleVerticalStack: TikkleVerticalStackView = {
        let stackView = TikkleVerticalStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 18
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()
    private let tikkleListManager: TikkleListManager = TikkleListManager()
    private let mainViewPadding: CGFloat = 20
    private let contentSectionPadding: CGFloat = 40
    private let contentPadding: CGFloat = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: 기본 UI Setting
private extension CreateTikklePageViewController {
    
    func setup() {
        mainViewSetup()
        addViews()
        autoLayoutSetup()
        keyboardNotificationSetup()
        navigationBarButtonSetup()
        photoTapSetup()
        challengeNameTextFieldSetup()
        infoTextViewSetup()
        stackViewSetup()
    }
    
    func mainViewSetup() {
        view.backgroundColor = .black
    }
    
    func addViews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(photoImageView)
        mainScrollView.addSubview(challengeNameLabel)
        mainScrollView.addSubview(challengeNameTextField)
        mainScrollView.addSubview(infoLabel)
        mainScrollView.addSubview(infoTextView)
        mainScrollView.addSubview(tikkleNameLable)
        mainScrollView.addSubview(tikkleVerticalStack)
    }
    
    func autoLayoutSetup() {
        let contentLayout = mainScrollView.contentLayoutGuide
        let frameLayout = mainScrollView.frameLayoutGuide
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(mainViewPadding)
        }
        photoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(142)
            make.top.equalTo(contentLayout.snp.top).inset(contentPadding)
            make.leading.equalTo(contentLayout.snp.leading)
        }
        challengeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).inset(-contentSectionPadding)
            make.leading.equalTo(contentLayout.snp.leading)
        }
        challengeNameTextField.snp.makeConstraints { make in
            make.top.equalTo(challengeNameLabel.snp.bottom).inset(-contentPadding)
            make.leading.trailing.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(challengeNameTextField.snp.bottom).inset(-contentSectionPadding)
            make.leading.equalToSuperview()
        }
        infoTextView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).inset(-contentPadding)
            make.leading.equalTo(contentLayout.snp.leading)
            make.trailing.equalTo(contentLayout.snp.trailing)
            make.width.equalTo(frameLayout.snp.width)
            make.height.equalTo(100)
        }
        tikkleNameLable.snp.makeConstraints { make in
            make.top.equalTo(infoTextView.snp.bottom).inset(-contentSectionPadding)
            make.leading.equalToSuperview()
        }
        tikkleVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(tikkleNameLable.snp.bottom).inset(-contentSectionPadding)
            make.leading.equalTo(contentLayout.snp.leading)
            make.bottom.equalTo(contentLayout.snp.bottom)
        }
        
    }
    
    // 키보드가 올라가거나 내려갈때 실행 시킬 함수를 등록해주는 함수
    func keyboardNotificationSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: 키보드가 올라갈 경우 ViewController의 view를 키보드의 높이만큼 올리는 함수
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    
    //MARK: 키보드가 내려갈경우 view의 위치를 원래 상태로 되돌리는 함수
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
    
    //MARK: Navigation에 완료 버튼 생성
    private func navigationBarButtonSetup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(saveTikkle))
    }
    
    //MARK: NavigationBar에 완료 버튼 클릭 호출되는 함수
    // 적지 않은 내용이 있는지 확인하고 다 작성한 경우 Tikkle 클래스 생성후 화면 닫기
    //TODO: 어떤 값이 입력이 되지 않았는지 보여주기
    @objc func saveTikkle() {
        guard let challengeNameText = challengeNameTextField.text,
              let infoText = infoTextView.text else { return }
        if challengeNameText.isEmpty || infoText.isEmpty { return }
        let stampList = tikkleVerticalStack.convertStampList()
        if stampList.isEmpty { return }
        
        
        let image = getImage()
        
        let tikkle = TikkleSheet(image: image,title: challengeNameText, description: infoText, isSharedProject: false, stampList: stampList)
        tikkleListManager.addTikkle(tikkle)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: 이미지뷰에 클릭 이벤트 적용시키는 함수
    func photoTapSetup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(photoSelect))
        photoImageView.addGestureRecognizer(gesture)
        photoImageView.isUserInteractionEnabled = true
    }
    
    //MARK: 이미지뷰 클릭시 ImagePickerController를 불러오는 함수
    @objc func photoSelect() {
        //lazy var 사용해보기
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    //MARK: - challengeNameTextField 커스텀
    func challengeNameTextFieldSetup() {
        challengeNameTextField.attributedPlaceholder = NSAttributedString(string: "20자 이내로 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexCode: "ADADAD")])
        
        challengeNameTextField.borderStyle = .none
        let border = CALayer()
        challengeNameTextField.layoutIfNeeded()
        border.frame = CGRect(x: 0, y: challengeNameTextField.frame.size.height, width: mainScrollView.frame.width - 40, height: 1)
        border.backgroundColor = UIColor.white.cgColor
        challengeNameTextField.layer.addSublayer((border))
    }
    
    //MARK: - infoTextView 처음 보여지는 화면에서의 안내문구
    func infoTextViewSetup() {
        infoTextView.text = "40자 이내로 입력해주세요."
        infoTextView.textColor = UIColor(hexCode: "ADADAD")
        infoTextView.delegate = self
    }
    
    //MARK: - infoTextView 바깥을 클릭하면 편집 종료
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.infoTextView.resignFirstResponder()
    }
    
    func getImage() -> UIImage? {
        if photoImageView.image?.pngData() == UIImage(named: "addphoto")?.pngData() {
            let defaultImage = UIImage(named: "default")
            return defaultImage
        } else {
            return photoImageView.image
        }
    }
    
    //MARK: 스탬프를 한줄에 3개를 넣어줄 수평 스택뷰 생성 함수
    func createStackView() -> TikkleHorizontalStackView {
        let horizontalStackView = TikkleHorizontalStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.spacing = 12
        return horizontalStackView
    }
    
    // MARK: 스탬프버튼 생성 함수
    func createStampButton() -> StampButton {
        let stampButton = StampButton()
        stampButton.isEditeEnabled = true
        stampButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stampButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return stampButton
    }
    
    // MARK: +버튼 생성 함수
    func createAddButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .black.withAlphaComponent(0.4)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(hexCode: "7a7a7a")
        button.addTarget(self, action: #selector(createStamp), for: .touchUpInside)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexCode: "7A7a7a").cgColor
        button.layer.masksToBounds = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }
    
    //MARK: +버튼 클릭시 실행되는 함수(StampButton을 만드는 함수)
    @objc func createStamp() {
        // 수직 스택뷰의 맨 밑의 스택뷰를 가져온다.
        guard let horizontalStackView = tikkleVerticalStack.arrangedSubviews.last as? UIStackView else { return }
        // 맨밑의 스택뷰에 있는 버튼의 갯수
        let buttonCount = horizontalStackView.arrangedSubviews.count
        // 버튼이 3개일떄 + 버튼을 클릭한 경우
        if buttonCount == 3 {
            guard let button = horizontalStackView.arrangedSubviews.last else { return }
            
            // 1. 맨마지막 버튼인 +버튼을 지운다
            button.removeFromSuperview()
            // 2. 빈 스탬프 버튼을 생성해서 스택뷰에 넣어준다.
            horizontalStackView.addArrangedSubview(createStampButton())
            // 3. 수평방향의 스택뷰를 생성
            let newHorizontalStackView = createStackView()
            // 4. 새로운 수평 스택뷰에 +버튼 생성
            newHorizontalStackView.addArrangedSubview(createAddButton())
            // 5. 수직 스택뷰에 새로운 수평 스택뷰를 넣어준다,
            tikkleVerticalStack.addArrangedSubview(newHorizontalStackView)
            //6. 현재 스크롤의 위치를 가져온다.
            var contentOffset = mainScrollView.contentOffset
            //7. 현재 스크롤 위치에서 120(스택뷰의 크기)만큼 밑으로 설정해준다.
            contentOffset.y += 120
            //8. 120만큼 밑으로 내린 값을 애니메이션과 함께 적용하기
            mainScrollView.setContentOffset(contentOffset, animated: true)
        } else {
            // + 버튼을 지우고
            // 새로운 스탬프버튼 생성하고 스택뷰에 추가
            // +버튼을 새로 생성하고 스택뷰에 추가
            guard let button = horizontalStackView.arrangedSubviews.last else { return }
            button.removeFromSuperview()
            horizontalStackView.addArrangedSubview(createStampButton())
            horizontalStackView.addArrangedSubview(createAddButton())
        }
    }
    
    //MARK: 수직 스택뷰에 기본 설정 함수
    //수직 스택뷰 오토레이아웃 설정, 수평 스택뷰를 추가하고 그 안에 스탬프 버튼, +버튼 하나씩 추가
    func stackViewSetup() {
        
        let horizontalStackView = createStackView()
        tikkleVerticalStack.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(createStampButton())
        horizontalStackView.addArrangedSubview(createAddButton())
    }
    
}

//MARK: - challengeNameTextField 커스텀
extension CreateTikklePageViewController: UITextViewDelegate {
    //MARK: - infoTextView가 비어있다면 해당 문구를 출력해라
    func textViewDidEndEditing(_ textView: UITextView) {
        if infoTextView.text.isEmpty {
            infoTextView.text =  "40자 이내로 입력해주세요."
            infoTextView.textColor = UIColor(hexCode: "ADADAD")
        }
    }

    //MARK: - infoTextView가 클릭되었을때 ADADAD색 이라면 없애고 흰색으로 바꿔라
    func textViewDidBeginEditing(_ textView: UITextView) {
        if infoTextView.textColor == UIColor(hexCode: "ADADAD") {
            infoTextView.text = nil
            infoTextView.textColor = UIColor.white
        }
    }

}


extension CreateTikklePageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let infoImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = infoImage
        } 
        dismiss(animated: true)
    }
}
