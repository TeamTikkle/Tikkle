//
//  MakerViewController.swift
//  Practice_tikkle
//
//  Created by 김지훈 on 2023/09/15.
//

import UIKit
import SnapKit

class CreatorViewController: UIViewController {
    
    lazy var creatorTitle: UILabel = {
        let creatorTitle = UILabel()
        creatorTitle.font = .systemFont(ofSize: 20, weight: .regular)
        creatorTitle.text = "creatorPage"
        return creatorTitle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(creatorTitle)
        creatorTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
    }
    
}
