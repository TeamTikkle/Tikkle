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
    
    let headerArea = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    lazy var infoTableView: UITableView = {
        let infoTableView = UITableView()
        infoTableView.separatorStyle = .none
        infoTableView.backgroundColor = .black
        infoTableView.isScrollEnabled = false
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        return infoTableView
    }()
    
    lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "설정"
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headerLabel.textColor = .white
        headerLabel.textAlignment = .left
        return headerLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        infoTableViewPrint()
    }
    
    func infoTableViewPrint() {
        view.addSubview(infoTableView)
        
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        infoTableView.tableHeaderView = headerArea
        headerArea.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
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
