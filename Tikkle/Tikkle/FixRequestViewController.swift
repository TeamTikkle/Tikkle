//
//  FixRequestViewController.swift
//  Practice_tikkle
//
//  Created by 김지훈 on 2023/09/15.
//

import UIKit
import SnapKit

class FixRequestViewController: UIViewController {
    
    lazy var fixRequesttitle: UILabel = {
        let fixRequesttitle = UILabel()
        fixRequesttitle.font = .systemFont(ofSize: 20, weight: .regular)
        fixRequesttitle.text = "fixRequestPage"
        return fixRequesttitle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(fixRequesttitle)
        fixRequesttitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
    }
    
}
