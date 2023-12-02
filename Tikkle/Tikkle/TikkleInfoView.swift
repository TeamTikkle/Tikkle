//
//  TikkleInfoView.swift
//  Tikkle
//
//  Created by 김지훈 on 11/30/23.
//

import UIKit

class TikkleInfoView: UIView {
    
    //티끌 정보 전체 스택뷰
    lazy var tikkleTotalInfoStackView: UIStackView = {
        let tikkleTotalInfoStackView = UIStackView(arrangedSubviews: [tikkleImage, tikkleTitle, tikkleChallengeText, tikkleDateText, tikkleInfoText, tikkleChallengeButton])
        tikkleTotalInfoStackView.axis = .vertical
        tikkleTotalInfoStackView.alignment = .center
        tikkleTotalInfoStackView.spacing = 10
        tikkleTotalInfoStackView.backgroundColor = .black
        return tikkleTotalInfoStackView
    }()
    
    //티끌 이미지
    lazy var tikkleImage: UIImageView = {
        let tikkleImage = UIImageView()
        tikkleImage.contentMode = .scaleAspectFill
        tikkleImage.layer.cornerRadius = 60
        tikkleImage.clipsToBounds = true
        return tikkleImage
    }()
    
    //티끌 제목
    lazy var tikkleTitle: UILabel = {
        let tikkleTitle = UILabel()
        tikkleTitle.font = .systemFont(ofSize: 20, weight: .bold)
        tikkleTitle.textColor = .white
        return tikkleTitle
    }()
    
    //티끌 도전 상태
    lazy var tikkleChallengeText: UILabel = {
        let tikkleChallengeText = UILabel()
        tikkleChallengeText.font = .systemFont(ofSize: 13, weight: .regular)
        tikkleChallengeText.textColor = .mainColor
        return tikkleChallengeText
    }()
    
    //티끌 도전 시작일정
    lazy var tikkleDateText: UILabel = {
        let tikkleDateText = UILabel()
        tikkleDateText.font = .systemFont(ofSize: 13, weight: .regular)
        tikkleDateText.textColor = .subTitleColor
        return tikkleDateText
    }()
    
    //티끌 설명
    lazy var tikkleInfoText: UILabel = {
        let tikkleInfoText = UILabel()
        tikkleInfoText.font = .systemFont(ofSize: 15, weight: .regular)
        tikkleInfoText.textColor = .subTitleColor
        tikkleInfoText.numberOfLines = 2
        tikkleInfoText.backgroundColor = .black
        return tikkleInfoText
    }()
    
    //티끌 도전 버튼
    lazy var tikkleChallengeButton: UIButton = {
        let tikkleChallengeButton = UIButton()
        return tikkleChallengeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(tikkleTotalInfoStackView)
        tikkleTotalInfoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tikkleImage.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(120)
        }

    }

}
