//
//  FeedPageViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit

protocol ViewControllerPushDelegate: AnyObject {
    func pushViewController(tikkle: TikkleSheet)
}

class FeedPageViewController: UIViewController {
    private var combinedList: [TikkleSheet] {
        return tikkleListManager.getTikkleList() + DummyList.dummylist //✅합치고
    }
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    private var tikkleListManager: TikkleListManager = TikkleListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        feedCollectionView.register(OtherTikkleCollectionViewCell.self, forCellWithReuseIdentifier: OtherTikkleCollectionViewCell.identifier)
        feedCollectionView.register(OtherTikkleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OtherTikkleCollectionReusableView.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        feedCollectionView.reloadData()
    }
    
}

extension FeedPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ViewControllerPushDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0  // 줄 간의 최소 간격 설정
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)  // 섹션의 인셋 설정
    }

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //✅
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : combinedList.count
    }
    
    //✅ 필수 메서드 : 각 셀의 내용을 구성해줘
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as? HorizontalCollectionViewCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = 6
            cell.layer.masksToBounds = true
            cell.delegate = self
            return cell

        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherTikkleCollectionViewCell.identifier, for: indexPath) as? OtherTikkleCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
            cell.layer.cornerRadius = 6
            cell.layer.masksToBounds = true
            
            cell.tikkle = combinedList[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    //✅특정 셀 탭했을 때 실행 돼
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {

            //UIStoryboard 객체를 생성하여 TikklePage라는 이름의 스토리보드를 로드
            let storyboard = UIStoryboard(name: "TikklePage", bundle: nil)
            //뷰컨트롤러 인스턴스 생성
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TikklePageViewController") as? TikklePageViewController else { return }
            //데이터 할당. 여기서 합친 리스트를 줘.
            vc.tikkle = combinedList[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HotTikkleReusableView", for: indexPath)
            } else {
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OtherTikkleCollectionReusableView.identifier, for: indexPath)
            }
        default:
            assert(false, "헤더뷰가 아닙니다.")
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: .infinity, height: 130.0) : CGSize(width: .infinity, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = collectionView.bounds.width - 40.0
            let height = 258.0
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.bounds.width - 40.0
            let height = 220.0
            return CGSize(width: width, height: height)
        }
    }
    
    
    func pushViewController(tikkle: TikkleSheet) {
        let storyboard = UIStoryboard(name: "TikklePage", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TikklePageViewController") as? TikklePageViewController else { return }
        //MARK: - TikklePageViewController의 데이터를 어디로
        vc.tikkle = tikkle
        navigationController?.pushViewController(vc, animated: true)
    }
}
