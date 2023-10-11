//
//  TikkleListTableViewCell.swift
//  Tikkle
//
//  Created by FUTURE on 2023/08/16.
//

import UIKit
import SnapKit

class TikkleListTableViewCell: UITableViewCell {
    
    var circleViews: [UIView] = []
    
    
    let containerView: UIView = {
        let view = UIView()
        //        view.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        view.layer.cornerRadius = 5
        return view
    }()
    
    let squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3 // 행간 설정

            let attributedString = NSAttributedString(string: "Title",
                                                      attributes: [.paragraphStyle: paragraphStyle])
            label.attributedText = attributedString
        
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.7)
        return label
    }()

    
    lazy var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pinIcon")
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pinButtonTapped)))
        return imageView
    }()
    
    var isPinned: Bool = false
    
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    
    let achievementGraph: UIView = {
        let view = UIView()
        
        
        
        return view
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func pinButtonTapped() {
        isPinned.toggle()
        pinImageView.image = isPinned ? UIImage(named: "pinIcon.fill") : UIImage(named: "pinIcon")
        // 테이블뷰 상단에 셀 고정하는 로직 추가해야함. 아직 안 했음.
    }
    
    func setDateLabel(createDate: Date) {
        let currentDate = Date()
        let calendar = Calendar.current

        if let diff = calendar.dateComponents([.day], from: createDate, to: currentDate).day {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.dd"
            let formattedStartDate = dateFormatter.string(from: createDate)
            
            subTitleLabel.text = "\(diff+1)일째 도전중 \(formattedStartDate) ~ 현재"
        }
    }

    
    
    func setupUI() {
        
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        self.selectionStyle = .none
        
        
        self.backgroundColor = .clear
        
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        contentView.addSubview(containerView)
        contentView.addSubview(squareImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(pinImageView)
        contentView.addSubview(percentLabel)
        contentView.addSubview(achievementGraph)
        
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(contentView).offset(7.5)
            make.bottom.equalTo(contentView).offset(-7.5)
        }
        
        squareImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(135)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(squareImageView.snp.trailing).offset(20)
            make.top.equalTo(squareImageView).offset(5)
            make.trailing.lessThanOrEqualTo(contentView).offset(-20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.lessThanOrEqualTo(contentView).offset(-20)
        }
        
        pinImageView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel)
                make.leading.equalTo(titleLabel.snp.trailing).offset(10)
                make.trailing.equalTo(contentView).offset(-10)
                make.width.height.equalTo(20)
            }
        
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
        }
        
        achievementGraph.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel).offset(-1)
            make.top.equalTo(percentLabel.snp.bottom).offset(5)
            make.height.equalTo(15)
            make.bottom.equalTo(contentView).offset(-20)
            make.width.equalTo(contentView).offset(-135 - 35)
        }
        
        for i in 0..<10 {
            let circleView = UIView()
            circleView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            achievementGraph.addSubview(circleView)
            circleViews.append(circleView)
            
            circleView.snp.makeConstraints { make in
                make.height.equalTo(achievementGraph)
                make.width.equalTo(achievementGraph).dividedBy(13) // 동그라미와 간격을 고려한 너비 설정
                if i == 0 {
                    make.leading.equalTo(achievementGraph)
                } else {
                    make.leading.equalTo(circleViews[i-1].snp.trailing).offset(3)
                }
                make.centerY.equalTo(achievementGraph)
            }
            
            DispatchQueue.main.async {
                circleView.layer.cornerRadius = circleView.frame.height / 2.0
            }
        }
    }
    
    
}




