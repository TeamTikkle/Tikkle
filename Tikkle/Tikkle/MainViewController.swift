//
//  MainViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/21.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        viewControllerSetting()
        // Do any additional setup after loading the view.
    }
    
    private func configureTabBar() {
        let tabBar = self.tabBar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBar.standardAppearance = tabBarAppearance
        self.tabBar.tintColor = .mainColor
    }

    private func viewControllerSetting() {
        let vc1 = createNavigationController(viewController: TikkleViewController())
        let vc2 = createNavigationController(viewController: FeedViewController())
        let vc3 = createNavigationController(viewController: InfoViewController())

        self.setViewControllers([vc1, vc2, vc3], animated: false)

        guard let items = self.tabBar.items else { return }

        let unSelectedImages = ["tabBarTikkleListPageUnselected", "tabBarFeedPageUnselected", "tabBarMyPageUnselected"]
        let selectedImages = ["tabBarTikkleListPageSelected", "tabBarFeedPageSelected", "tabBarMyPageSelected"]

        for index in 0..<items.count {
            items[index].image = UIImage(named: unSelectedImages[index])
        }
        
        // 선택된 아이템의 이미지와 색상 설정
        if let items = self.tabBar.items {
            for index in 0..<items.count {
                items[index].selectedImage = UIImage(named: selectedImages[index])
            }
        }
    }
    
    private func configureNavigationBar(navigationController: UINavigationController) -> UINavigationController {
        let navigationBar = navigationController.navigationBar
        let naviBarAppearance = UINavigationBarAppearance()
        naviBarAppearance.configureWithTransparentBackground()
        navigationBar.standardAppearance = naviBarAppearance
        navigationBar.scrollEdgeAppearance = naviBarAppearance
        
        return navigationController
    }
    
    private func createNavigationController(viewController: UIViewController) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return configureNavigationBar(navigationController: navigationController)
    }
}
