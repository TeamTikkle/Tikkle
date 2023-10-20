//
//  TikkleSheetCell.swift
//  Tikkle
//
//  Created by 김지훈 on 2023/09/17.
//

import UIKit
import SnapKit

class TikkleSheetCell: UICollectionViewCell {
    static let identifier = "TikkleSheetCell"
    
    var tikkle: TikkleSheet?
    //MARK: -
    var index: Int?
    //MARK: -
    var tikkleList: TikkleListManager = TikkleListManager()
    
    lazy var tikkleButton: UIButton = {
        let tikkleButton = UIButton()
        
//        let image = UIImage(systemName: "face.smiling")?.imageWith(newSize: .init(width: 100, height: 100))
//        tikkleButton.setImage(image, for: .normal)
        
        return tikkleButton
    }()
    
    lazy var tikkleNameText: UILabel = {
        let tikkleNameText = UILabel()
        tikkleNameText.font = .systemFont(ofSize: 15, weight: .regular)
        tikkleNameText.textColor = .mainColor
        return tikkleNameText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellPrint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
    
    func cellPrint() {
        contentView.addSubview(tikkleButton)
        contentView.addSubview(tikkleNameText)
        
        tikkleButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
        
        tikkleNameText.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    func cellUISetting(tikkle: TikkleSheet?, index: Int) {
        guard let tikkle else { return }
        self.tikkle = tikkle
        self.index = index
        
        tikkleNameText.text = tikkle.stampList[index].title
        if tikkle.stampList[index].isCompletion == true {
            tikkleButton.setImage(UIImage(named: "TikkleON"), for: .normal)
        } else {
            tikkleButton.setImage(UIImage(named: "TikkleOFF"), for: .normal)
        }
    }
}

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image.withRenderingMode(renderingMode)
    }
}
