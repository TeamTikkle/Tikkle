//
//  InfoViewController.swift
//  Practice_tikkle
//
//  Created by 김지훈 on 2023/09/14.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    let infoMenu = ["공지사항", "기능 추가 요청 / 오류 신고", "만든이"]
    let infoTableSection = ["version", "infomenu"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        infoTableViewPrint()
    }
    
    func navigationUI() {
        let logoImage = UIImage(named: "navi_Logo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        let logoItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = logoItem
        
        navigationItem.title = "설정"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.backgroundColor = .clear
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    lazy var infoTableView: UITableView = {
        let infoTableView = UITableView()
        infoTableView.separatorStyle = .none
        infoTableView.isScrollEnabled = false
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        infoTableView.backgroundColor = .black
        return infoTableView
    }()
    
    func infoTableViewPrint() {
        view.addSubview(infoTableView)
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoTableSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return infoMenu.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.infoMenuTitle.textColor = .white
        cell.versionText.textColor = .white
        
        if indexPath.section == 0 {
            cell.infoMenuTitle.text = "버전"
            cell.versionText.text = "1.0.1"
        } else if indexPath.section == 1 {
            cell.infoMenuTitle.text = infoMenu[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        } else {
            return UITableViewCell()
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let page = [NoticeViewController(), FixRequestViewController(), CreatorViewController()]
        
        if indexPath.section == 0 {
            return
        } else if indexPath.section == 1 {
            navigationController?.pushViewController(page[indexPath.row], animated: true)
        } else {
            return
        }
    }
    
}
