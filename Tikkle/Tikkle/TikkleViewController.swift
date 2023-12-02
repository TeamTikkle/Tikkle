//
//  TikkleSheetViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit
import SnapKit

class TikkleViewController: UIViewController {
    
    var tikkle: TikkleSheet?
    var tikkleListManager: TikkleListManager = TikkleListManager()
    var isChallenged: Bool = false
    
    lazy var tikkleIntroStackView: UIStackView = {
        let tikkleIntroStackView = UIStackView(arrangedSubviews: [tikkleImage, tikkleTitle, tikkleChallengeStackView, tikkleInfoText, tikkleChallengeButton])
        tikkleIntroStackView.axis = .vertical
        tikkleIntroStackView.alignment = .center
        tikkleIntroStackView.spacing = 10
        tikkleIntroStackView.backgroundColor = .black
        return tikkleIntroStackView
    }()
    
    lazy var tikkleImage: UIImageView = {
        let tikkleImage = UIImageView()
        tikkleImage.contentMode = .scaleAspectFill
        tikkleImage.layer.cornerRadius = tikkleImage.frame.height / 2
        tikkleImage.clipsToBounds = true
        return tikkleImage
    }()
    
    lazy var tikkleTitle: UILabel = {
        let tikkleTitle = UILabel()
        tikkleTitle.font = .systemFont(ofSize: 20, weight: .bold)
        tikkleTitle.textColor = .white
        return tikkleTitle
    }()
    
    lazy var tikkleChallengeStackView: UIStackView = {
        let tikkleChallengeStackView = UIStackView(arrangedSubviews: [tikkleChallengeText, tikkleDateText])
        tikkleChallengeStackView.axis = .horizontal
        tikkleChallengeStackView.spacing = 10
        return tikkleChallengeStackView
    }()
    
    lazy var tikkleChallengeText: UILabel = {
        let tikkleChallengeText = UILabel()
        tikkleChallengeText.font = .systemFont(ofSize: 13, weight: .regular)
        tikkleChallengeText.textColor = .mainColor
        return tikkleChallengeText
    }()
    
    lazy var tikkleDateText: UILabel = {
        let tikkleDateText = UILabel()
        tikkleDateText.font = .systemFont(ofSize: 13, weight: .regular)
        tikkleDateText.textColor = .subTitleColor
        return tikkleDateText
    }()
    
    lazy var tikkleInfoText: UILabel = {
        let tikkleInfoText = UILabel()
        tikkleInfoText.font = .systemFont(ofSize: 15, weight: .regular)
        tikkleInfoText.textColor = .subTitleColor
        tikkleInfoText.numberOfLines = 2
        tikkleInfoText.backgroundColor = .black
        return tikkleInfoText
    }()
    
    lazy var tikkleChallengeButton: UIButton = {
        let tikkleChallengeButton = UIButton()
        return tikkleChallengeButton
    }()
    
    lazy var tikkleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let tikkleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tikkleCollectionView.backgroundColor = .systemBackground
        tikkleCollectionView.register(TikkleSheetCell.self, forCellWithReuseIdentifier: "TikkleSheetCell")
        tikkleCollectionView.delegate = self
        tikkleCollectionView.dataSource = self
        tikkleCollectionView.backgroundColor = .black
        return tikkleCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationSetting()
        uiSet()
    }
    
    //MARK: - TikklePage NavigationBar 커스텀
    func navigationSetting() {
        guard let navigationBar = navigationController?.navigationBar else {return}
        let naviBarAppearance = UINavigationBarAppearance()
        naviBarAppearance.configureWithTransparentBackground()
        navigationBar.standardAppearance = naviBarAppearance
        navigationBar.scrollEdgeAppearance = naviBarAppearance

        self.navigationController?.navigationBar.tintColor = UIColor.mainColor
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let deleteImage = UIImage(named: "navi_delete")
        let deleteImageView = UIImageView(image: deleteImage)
        deleteImageView.contentMode = .scaleAspectFit
        let deleteItem = UIBarButtonItem(customView: deleteImageView)
        //hoon
        deleteItem.target = self
        deleteItem.action = #selector(TikkleViewController.deleteAlert)
        navigationItem.rightBarButtonItem = deleteItem

    }
    
    //MARK: - 포기하기 버튼 동작
    @objc func deleteAlert() {
        let deleteAlert = UIAlertController(title: "정말로 포기하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let deleteCancelBtn = UIAlertAction(title: "취소", style: .cancel)
        let deleteOKBtn = UIAlertAction(title: "포기", style: .default) { [weak self] _ in
            guard let self, let tikkle else { return }
            
            tikkleListManager.deleteTikkle(where: tikkle.id)
            self.navigationController?.popViewController(animated: true)
        }
        
        deleteAlert.addAction(deleteCancelBtn)
        deleteAlert.addAction(deleteOKBtn)
        
        self.present(deleteAlert, animated: true)
    }
    
    //MARK: - TikklePage Image, Title, Info, 날짜 세팅 가져오기
    func uiSet() {
        view.addSubview(tikkleIntroStackView)
        tikkleIntroStackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
        }
        
        tikkleImage.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(110)
        }
        
        guard let unwrappedTikkle = tikkle else { return }
        
        tikkleImage.image = unwrappedTikkle.image
        tikkleTitle.text = unwrappedTikkle.title
        tikkleInfoText.text = unwrappedTikkle.description
        updateLabelsBasedOnChallenge(isChallenge: tikkleListManager.getTikkle(where: unwrappedTikkle.id) != nil)
        challengeUpdate(isChallenge: tikkleListManager.getTikkle(where: unwrappedTikkle.id) != nil)
    
        tikkleChallengeButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        view.addSubview(tikkleCollectionView)
        tikkleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tikkleIntroStackView.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func updateLabelsBasedOnChallenge(isChallenge: Bool) {
        if isChallenge {
            updateDateLabel()
            updateDaysLabel()
            tikkleChallengeText.isHidden = false
            tikkleChallengeText.isHidden = false
        } else {
            tikkleChallengeText.text = "00.00.00"
            tikkleChallengeText.text = "도전중이 아닙니다"
        }
    }
    
    //날짜 출력 함수
    func updateDateLabel() {
        guard let tikkle = tikkle else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd ~ 현재"
        let formattedDate = dateFormatter.string(from: tikkle.createDate)
        tikkleDateText.text = formattedDate
    }
    
    //n일 째 도전 중 출력 함수
    func updateDaysLabel() {
        guard let createDate = tikkle?.createDate else { return }

        let currentDate = Date()
        let calendar = Calendar.current

        // createDate와 현재 날짜 사이의 차이 계산
        if let diff = calendar.dateComponents([.day], from: createDate, to: currentDate).day {
            tikkleChallengeText.text = "\(diff+1)일째 도전 중"
        }
    }
    
    func challengeUpdate(isChallenge: Bool) {
        if isChallenge {
            tikkleChallengeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            tikkleChallengeButton.setTitle("도전중", for: .normal)
            tikkleChallengeButton.setTitleColor(.black, for: .normal)
            tikkleChallengeButton.isUserInteractionEnabled = false
            tikkleChallengeButton.backgroundColor = .mainColor
            tikkleChallengeButton.layer.cornerRadius = 17
            tikkleChallengeButton.layer.masksToBounds = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .mainColor
        } else {
            guard tikkle != nil else { return }
            tikkleChallengeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            tikkleChallengeButton.setTitle("도전하기", for: .normal)
            tikkleChallengeButton.setTitleColor(.black, for: .normal)
            tikkleChallengeButton.backgroundColor = .mainColor
            tikkleChallengeButton.layer.cornerRadius = 17
            tikkleChallengeButton.layer.masksToBounds = true
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
        }
                        
    }

}

//MARK: - TikklePage CollectionView Setting
extension TikkleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tikkle?.stampList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TikkleSheetCell.identifier, for: indexPath) as! TikkleSheetCell
        
        cell.cellUISetting(tikkle: tikkle, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let spacing: CGFloat = 10
        let availableWidth = collectionView.bounds.width - (spacing * (numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tikkle,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TikkleSheetCell", for: indexPath) as? TikkleSheetCell else { return }
        if tikkleListManager.getTikkle(where: tikkle.id) == nil { return }
        let index = indexPath.row
        
        tikkle.stampList[index].isCompletion = !tikkle.stampList[index].isCompletion
        
        if tikkle.stampList[index].isCompletion == true {
            cell.tikkleButton.setImage(UIImage(named: "TikkleON.png"), for: .normal)
        } else {
            cell.tikkleButton.setImage(UIImage(named: "TikkleOFF.png"), for: .normal)
        }
        cell.tikkleList.updateTikkleInfo(index: index, tikkle)
        collectionView.reloadData()
    }
}
