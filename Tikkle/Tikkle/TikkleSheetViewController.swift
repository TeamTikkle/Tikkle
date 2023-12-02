//
//  TikkleSheetViewController.swift
//  Tikkle
//
//  Created by 김지훈 on 11/30/23.
//

import UIKit

class TikkleSheetViewController: UIViewController {
    
    var tikkle: TikkleSheet?
    var tikkleListManager: TikkleListManager = TikkleListManager()
    var isChallenged: Bool = false
    
    private lazy var tikkleInfoView = TikkleInfoView()
    private lazy var tikkleCollectionView = TikkleCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        navigationSetting()
//        tikkleCollectionSetting()
        setupUI()
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
        deleteItem.action = #selector(TikkleSheetViewController.deleteAlert)
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
    
//    func tikkleCollectionSetting() {
//        tikkleCollectionView.dataSource = self
//        tikkleCollectionView.delegate = self
//    }
    
    func setupUI() {
        view.addSubview(tikkleInfoView)
        view.addSubview(tikkleCollectionView)
        
        tikkleInfoView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
        }
        
        guard let unwrappedTikkle = tikkle else { return }
        
        tikkleInfoView.tikkleImage.image = unwrappedTikkle.image
        
        
        
        tikkleInfoView.tikkleTitle.text = unwrappedTikkle.title
        tikkleInfoView.tikkleInfoText.text = unwrappedTikkle.description
        updateLabelsBasedOnChallenge(isChallenge: tikkleListManager.getTikkle(where: unwrappedTikkle.id) != nil)
        challengeUpdate(isChallenge: tikkleListManager.getTikkle(where: unwrappedTikkle.id) != nil)
    
        tikkleInfoView.tikkleChallengeButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        tikkleCollectionView.dataSource = self
        tikkleCollectionView.delegate = self
        
        tikkleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tikkleInfoView.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        tikkleCollectionView.register(TikkleSheetCell.self, forCellWithReuseIdentifier: "TikkleSheetCell")
    }
    
    func updateLabelsBasedOnChallenge(isChallenge: Bool) {
        if isChallenge {
            updateDateLabel()
            updateDaysLabel()
            tikkleInfoView.tikkleChallengeText.isHidden = false
            tikkleInfoView.tikkleChallengeText.isHidden = false
        } else {
            tikkleInfoView.tikkleChallengeText.text = "00.00.00"
            tikkleInfoView.tikkleChallengeText.text = "도전중이 아닙니다"
        }
    }
    
    //날짜 출력 함수
    func updateDateLabel() {
        guard let tikkle = tikkle else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd ~ 현재"
        let formattedDate = dateFormatter.string(from: tikkle.createDate)
        tikkleInfoView.tikkleDateText.text = formattedDate
    }
    
    //n일 째 도전 중 출력 함수
    func updateDaysLabel() {
        guard let createDate = tikkle?.createDate else { return }

        let currentDate = Date()
        let calendar = Calendar.current

        // createDate와 현재 날짜 사이의 차이 계산
        if let diff = calendar.dateComponents([.day], from: createDate, to: currentDate).day {
            tikkleInfoView.tikkleChallengeText.text = "\(diff+1)일째 도전 중"
        }
    }
    
    //
    func challengeUpdate(isChallenge: Bool) {
        if isChallenge {
            tikkleInfoView.tikkleChallengeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            tikkleInfoView.tikkleChallengeButton.setTitle("도전중", for: .normal)
            tikkleInfoView.tikkleChallengeButton.setTitleColor(.black, for: .normal)
            tikkleInfoView.tikkleChallengeButton.isUserInteractionEnabled = false
            tikkleInfoView.tikkleChallengeButton.backgroundColor = .mainColor
            tikkleInfoView.tikkleChallengeButton.layer.cornerRadius = 17
            tikkleInfoView.tikkleChallengeButton.layer.masksToBounds = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .mainColor
        } else {
            guard tikkle != nil else { return }
            tikkleInfoView.tikkleChallengeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            tikkleInfoView.tikkleChallengeButton.setTitle("도전하기", for: .normal)
            tikkleInfoView.tikkleChallengeButton.setTitleColor(.black, for: .normal)
            tikkleInfoView.tikkleChallengeButton.backgroundColor = .mainColor
            tikkleInfoView.tikkleChallengeButton.layer.cornerRadius = 17
            tikkleInfoView.tikkleChallengeButton.layer.masksToBounds = true
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
        }
                        
    }


}

//MARK: - TikklePage CollectionView Setting
extension TikkleSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

