//
//  FeedPageViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit

protocol ViewControllerPushDelegate: AnyObject {
    func pushViewController(tikkle: Tikkle)
}

class FeedPageViewController: UIViewController {
        
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        feedCollectionView.register(OtherTikkleCollectionViewCell.self, forCellWithReuseIdentifier: OtherTikkleCollectionViewCell.identifier)
        feedCollectionView.register(OtherTikkleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OtherTikkleCollectionReusableView.identifier)
        navigationSetting()
    }
    
    func navigationSetting() {
        guard let naviBar = navigationController?.navigationBar,
              let tabBar = tabBarController?.tabBar else { return }
        let naviBarAppearance = UINavigationBarAppearance()
        naviBarAppearance.configureWithTransparentBackground()
        naviBar.standardAppearance = naviBarAppearance
        naviBar.scrollEdgeAppearance = naviBarAppearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
        
}

extension FeedPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ViewControllerPushDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : DataList.list.count
    }
    
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
            cell.tikkle = DataList.list[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: "TikklePage", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TikklePageViewController") as? TikklePageViewController else { return }
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
    
    func pushViewController(tikkle: Tikkle) {
        let storyboard = UIStoryboard(name: "TikklePage", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TikklePageViewController") as? TikklePageViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
