//
//  TikkleCollectionView.swift
//  Tikkle
//
//  Created by 김지훈 on 11/30/23.
//

import UIKit

class TikkleCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(TikkleSheetCell.self, forCellWithReuseIdentifier: "TikkleSheetCell")
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
