//
//  AnotherTikkleCollectionViewCell.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/16.
//

import UIKit

class OtherTikkleCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "\(OtherTikkleCollectionViewCell.self)"
    lazy var tikkleStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [tikkleTitleLabel, tikkleDescriptionLabel])
        st.axis = .vertical
        st.alignment = .leading
        st.distribution = .fillProportionally
        st.spacing = 8
        return st
    }()
    let tikkleTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "매일 commit 하기"
        lb.font = .systemFont(ofSize: 18, weight: .semibold)
        lb.textColor = .white
        return lb
    }()
    let tikkleDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "커밋을 1일 1커밋 하기위해서 어쩌구 저꺼구"
        lb.font = .systemFont(ofSize: 16, weight: .regular)
        lb.textColor = .gray
        return lb
    }()
    let backgroundImageView = UIImageView(image: UIImage(named: "profileImg"))
    var tikkle: TikkleSheet? = nil {
        didSet {
            if tikkle != nil {
                uiSetting()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundImageView.contentMode = .scaleToFill
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(tikkleStackView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75).isActive = true
        
        tikkleStackView.translatesAutoresizingMaskIntoConstraints = false
        tikkleStackView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 12).isActive = true
        tikkleStackView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        tikkleStackView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        tikkleStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func uiSetting() {
        guard let tikkle else { return }
        backgroundImageView.image = UIImage(named: "default")
        DispatchQueue.global().async {
            let image = UIImage(data: tikkle.image!.pngData()!)
            DispatchQueue.main.async {
                self.backgroundImageView.image = image
            }
        }
        tikkleTitleLabel.text = tikkle.title
        tikkleDescriptionLabel.text = tikkle.description
    }
    
}
