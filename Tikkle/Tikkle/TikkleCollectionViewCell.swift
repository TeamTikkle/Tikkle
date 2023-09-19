//
//  TikklePageCollectionViewCell.swift
//  Tikkle
//
//  Created by 김지훈 on 2023/08/15.
//

import UIKit

class TikkleCollectionViewCell: UICollectionViewCell {
    
    var tikkle: TikkleSheet?
    //MARK: -
    var index: Int?
    //MARK: -
    var tikkleList: TikkleListManager = TikkleListManager()
    
    @IBOutlet weak var TikklePageCellBtnImg: UIButton!
    @IBOutlet weak var TikklePageCellName: UILabel!
    
    //MARK: - TikklePage에 있는 Cell 하나하나의 값을 가져오는 tikkle 데이터와 index 순번으로 값을 알아내고 그 데이터대로 ON, OFF 이미지를 노출한다.
    func cellUISetting(tikkle: TikkleSheet?, index: Int) {
        guard let tikkle else { return }
        self.tikkle = tikkle
        self.index = index
        
        TikklePageCellName.text = tikkle.stampList[index].title
        if tikkle.stampList[index].isCompletion == true {
            TikklePageCellBtnImg.setImage(UIImage(named: "TikkleON.png"), for: .normal)
        } else {
            TikklePageCellBtnImg.setImage(UIImage(named: "TikkleOFF.png"), for: .normal)
        }
    }
    
}
