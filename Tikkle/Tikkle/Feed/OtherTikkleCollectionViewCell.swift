//
//  AnotherTikkleCollectionViewCell.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/16.
//

import UIKit

class OtherTikkleCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "\(OtherTikkleCollectionViewCell.self)"
    lazy var userStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [userImageView, userNameLabel])
        st.axis = .horizontal
        st.alignment = .center
        st.distribution = .equalSpacing
        st.isLayoutMarginsRelativeArrangement = true
        st.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
        st.backgroundColor = UIColor(hexCode: "08190A")
        return st
    }()
    let userImageView: UIImageView = UIImageView(image: UIImage(named: "profileImg"))
    let userNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "test_ID"
        lb.font = .systemFont(ofSize: 15, weight: .regular)
        lb.textColor = .white
        return lb
    }()
    lazy var tikkleStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [kikkleTitleLabel, likeButton])
        st.axis = .horizontal
        st.alignment = .center
        st.distribution = .equalSpacing
        st.isLayoutMarginsRelativeArrangement = true
        st.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        st.backgroundColor = .black.withAlphaComponent(0.6)
        return st
    }()
    let kikkleTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "매일 commit 하기"
        lb.font = .systemFont(ofSize: 15, weight: .semibold)
        lb.textColor = .white
        return lb
    }()
    let likeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        btn.tintColor = .mainColor
        return btn
    }()
    let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .subTitleColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    var progressBarAnimationLayer: CALayer? = nil
    
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
        
        likeButton.addTarget(self, action: #selector(likeButtonClick), for: .touchUpInside)
        
        backgroundImageView.contentMode = .scaleToFill
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(userStackView)
        contentView.addSubview(tikkleStackView)
        contentView.addSubview(progressBar)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor).isActive = true
        userStackView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        userStackView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        userStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tikkleStackView.translatesAutoresizingMaskIntoConstraints = false
        tikkleStackView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        tikkleStackView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        tikkleStackView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        tikkleStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 10).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeButtonClick() {
        likeButton.isSelected = !likeButton.isSelected
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
        kikkleTitleLabel.text = tikkle.title
        progressBarFill()
    }
    
    private func progressBarFill() {
        guard let tikkle else { return }
        
        layoutIfNeeded()
                
        let notCompleteCount = tikkle.stampList.count - tikkle.stampList.filter { $0.isCompletion }.count
        let completeRate: Double = Double(notCompleteCount) / Double(tikkle.stampList.count)
        
        progressBarAnimationLayer?.removeFromSuperlayer()
        let fillLayer = progressBarLayer(completeRate: completeRate)
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = progressBar.bounds.height + (progressBar.bounds.height / 2)
        animation.toValue = (progressBar.bounds.height * completeRate) + (progressBar.bounds.height / 2)
        animation.duration = 0.7
        fillLayer.add(animation, forKey: "ProgressBarAnimation")
        progressBar.layer.addSublayer(fillLayer)
        progressBarAnimationLayer = fillLayer
    }
    
    private func progressBarLayer(completeRate: CGFloat) -> CALayer {
        let fillLayer = CALayer()
        fillLayer.frame = CGRect(x: 0, y: progressBar.bounds.height * completeRate, width: progressBar.bounds.width, height: progressBar.bounds.height)
        fillLayer.backgroundColor = UIColor.mainColor.cgColor
        return fillLayer
    }
    
}
