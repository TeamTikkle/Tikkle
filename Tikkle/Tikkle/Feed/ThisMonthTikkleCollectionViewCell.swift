//
//  RecommendCollectionViewCell.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/16.
//

import UIKit

class ThisMonthTikkleCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "\(ThisMonthTikkleCollectionViewCell.self)"
    private let backgroundImageView: UIImageView = UIImageView(image: UIImage(named: "TikkleON"))
    private lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [titleLabel,challengeCountLabel])
        st.axis = .vertical
        st.spacing = 8
        st.alignment = .fill
        st.distribution = .equalCentering
        return st
    }()
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 18, weight: .semibold)
        lb.textColor = .white
        lb.text = "편의점 맥주 도장깨기"
        return lb
    }()
    private let challengeCountLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .medium)
        lb.textColor = .white
        lb.text = "216명 도전중"
        lb.alpha = 0.6
        return lb
    }()
    private let gradientView: UIView = UIView()
    var tikkle: TikkleSheet? = nil {
        didSet {
            if tikkle != nil {
                uiSetting()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(gradientView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -32).isActive = true
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        backgroundImageGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func uiSetting() {
        guard let tikkle else { return }
        titleLabel.text = tikkle.title
        
        backgroundImageView.image = tikkle.image
        backgroundImageView.contentMode = .scaleAspectFill
        if let gradientLayer = backgroundImageView.layer.sublayers?.first {
            gradientLayer.removeFromSuperlayer()
            backgroundImageGradient()
        }
    }
    
    private func backgroundImageGradient() {
        let startColor = UIColor(red: 30/255, green: 113/255, blue: 79/255, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.colors = [startColor, endColor]
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
