//
//  TikkleHorizontalStackView.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/18.
//

import UIKit

class TikkleHorizontalStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func convertButtonIntoStampList() -> [Tikkle] {
        var stampStringList = [Tikkle]()
        for view in arrangedSubviews {
            guard let button = view as? StampButton else { continue }
            let text = button.stampTitle()
            if text.isEmpty { continue }
            let stamp = Tikkle(title: text, isCompletion: false)
            stampStringList.append(stamp)
        }
        return stampStringList
    }
    
}
