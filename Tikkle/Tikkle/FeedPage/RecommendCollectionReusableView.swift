//
//  RecommendCollectionReusableView.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/16.
//

import UIKit

class RecommendCollectionReusableView: UICollectionReusableView, Reusable {
    
    private var hotButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(hotButton)
    }
}
