//
//  NotificationViewController.swift
//  Practice_tikkle
//
//  Created by 김지훈 on 2023/09/15.
//

import UIKit
import SnapKit

class NoticeViewController: UIViewController {
    
    lazy var noticetitle: UILabel = {
        let noticetitle = UILabel()
        noticetitle.font = .systemFont(ofSize: 20, weight: .regular)
        noticetitle.text = "noticePage"
        return noticetitle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(noticetitle)
        noticetitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
    }
    
}
