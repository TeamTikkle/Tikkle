//
//  TikklePageViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit

class TikkleViewController: UIViewController {
    
    var tikkle: TikkleSheet?
    var tikkleListManager: TikkleListManager = TikkleListManager()
    var isChallenged: Bool = false
    
    @IBOutlet weak var TikklePageImage: UIImageView!
    @IBOutlet weak var TikklePageTitle: UILabel!
    @IBOutlet weak var TikklePageDaysLabel: UILabel!
    @IBOutlet weak var TikklePageDateLabel: UILabel!
    @IBOutlet weak var TikklePageInfo: UILabel!
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var TikklePageCollectionView: UICollectionView!
    private let tikklePageCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationSetting()
        uiSet()
        
        tikklePageCollectionView.delegate = self
        tikklePageCollectionView.dataSource = self
    }
    
    //MARK: - TikklePage NavigationBar 커스텀
    func navigationSetting() {
        guard let naviBar = navigationController?.navigationBar else { return }
        
        self.navigationController?.navigationBar.tintColor = UIColor.mainColor
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let deleteImage = UIImage(named: "delete")
        let deleteImageview = UIImageView(image: deleteImage)
        deleteImageview.contentMode = .scaleAspectFit
        
        //MARK: - TikklePage 포기하기 버튼 커스텀, 클릭 시 deleteAlert 함수 실행
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: deleteImage, style: .plain, target: self, action: #selector(TikkleViewController.deleteAlert))
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
        guard let unwrappedTikkle = tikkle else { return }
        
        TikklePageImage.image = unwrappedTikkle.image
        TikklePageImage.contentMode = .scaleAspectFill
        TikklePageImage.layer.cornerRadius = TikklePageImage.frame.height / 2
        TikklePageTitle.text = unwrappedTikkle.title
        TikklePageInfo.text = unwrappedTikkle.description
        updateLabelsBasedOnChallenge(isChallenge: tikkleListManager.getTikkle(where: unwrappedTikkle.id) != nil)
        challengeUpdate(isChallenge: tikkleListManager.getTikkle(where: unwrappedTikkle.id) != nil)
    }
    
    
    func updateLabelsBasedOnChallenge(isChallenge: Bool) {
        if isChallenge {
            updateDateLabel()
            updateDaysLabel()
            TikklePageDateLabel.isHidden = false
            TikklePageDaysLabel.isHidden = false
        } else {
            TikklePageDateLabel.text = "00.00.00"
            TikklePageDaysLabel.text = "도전중이 아닙니다"
        }
    }
    
    
    //날짜 출력 함수
    func updateDateLabel() {
        
        guard let tikkle = tikkle else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd ~ 현재"
        let formattedDate = dateFormatter.string(from: tikkle.createDate)
        TikklePageDateLabel.text = formattedDate
    }
    
    
    
    //n일 째 도전 중 출력 함수
    func updateDaysLabel() {
        guard let createDate = tikkle?.createDate else { return }

        let currentDate = Date()
        let calendar = Calendar.current

        // createDate와 현재 날짜 사이의 차이 계산
        if let diff = calendar.dateComponents([.day], from: createDate, to: currentDate).day {
            TikklePageDaysLabel.text = "\(diff+1)일째 도전 중"
        }
    }
    
    
    func challengeUpdate(isChallenge: Bool) {
        if isChallenge {
            challengeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            challengeButton.setTitle("도전중", for: .normal)
            challengeButton.isUserInteractionEnabled = false
            challengeButton.backgroundColor = .mainColor
            challengeButton.layer.cornerRadius = 17
            challengeButton.layer.masksToBounds = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .mainColor
        } else {
            guard let tikkle else { return }
            challengeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            challengeButton.setTitle("도전하기", for: .normal)
            challengeButton.backgroundColor = .mainColor
            challengeButton.layer.cornerRadius = 17
            challengeButton.layer.masksToBounds = true
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
        }
                        
    }
    @IBAction func callengeStart(_ sender: Any) {
        guard let tikkle else { return }
        updateDateLabel()
        updateDaysLabel()
        tikkleListManager.addTikkle(tikkle)
        challengeUpdate(isChallenge: true)
    }
}

//MARK: - TikklePage CollectionView Setting
extension TikkleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tikkle?.stampList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TikklePageCollectionView.dequeueReusableCell(withReuseIdentifier: "TikklePageCollectionViewCell", for: indexPath) as! TikkleCollectionViewCell
        
        cell.cellUISetting(tikkle: tikkle, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = TikklePageCollectionView.frame.width / 3 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tikkle,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TikklePageCollectionViewCell", for: indexPath) as? TikkleCollectionViewCell else { return }
        if tikkleListManager.getTikkle(where: tikkle.id) == nil { return }
        let index = indexPath.row
        
        tikkle.stampList[index].isCompletion = !tikkle.stampList[index].isCompletion
        
        if tikkle.stampList[index].isCompletion == true {
            cell.TikklePageCellBtnImg.setImage(UIImage(named: "TikkleON.png"), for: .normal)
        } else {
            cell.TikklePageCellBtnImg.setImage(UIImage(named: "TikkleOFF.png"), for: .normal)
        }
        cell.tikkleList.updateTikkleInfo(index: index, tikkle)
        collectionView.reloadData()
    }
}
