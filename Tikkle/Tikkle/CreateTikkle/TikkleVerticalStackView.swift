//
//  TikkleVerticalStackView.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/18.
//

import UIKit

class TikkleVerticalStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: 함수명 고민해보기
    func convertStampList() -> [Tikkle] {
        var stampStringList = [Tikkle]()
        for view in arrangedSubviews {
            guard let horizontalStackView = view as? TikkleHorizontalStackView else { continue }
            stampStringList.append(contentsOf: horizontalStackView.convertButtonIntoStampList())
        }
        return stampStringList
    }
    
}
