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
        view.backgroundColor = UIColor.white.withAlphaComponent(0.08)
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
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        
        let attributedString = NSMutableAttributedString(string: "30일간 TIL 매일 작성하기")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // 행간 설정
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        
        return label
    }()
    
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.text = "30%"
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
    
    

    
    
    
    func setupUI() {
        self.selectionStyle = .none
        
        
        self.backgroundColor = .clear
        
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView) // 좌우는 contentView에 붙이고,
            make.top.equalTo(contentView).offset(7.5)   // 위쪽은 7.5만큼 떨어뜨리고,
            make.bottom.equalTo(contentView).offset(-7.5) // 아래쪽은 7.5만큼 떨어뜨림
        }
        
        // squareImageView 설정 및 배치
        contentView.addSubview(squareImageView)
        squareImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(135)
        }
        
        // titleLabel 설정 및 배치
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(squareImageView.snp.trailing).offset(20)
            make.top.equalTo(contentView).offset(10)
            make.trailing.lessThanOrEqualTo(contentView).offset(-20)
        }
        titleLabel.numberOfLines = 2  // 최대 2줄
        titleLabel.lineBreakMode = .byTruncatingTail  // 두 줄이 넘어가면 '...'으로 표시
        
        // percentLabel 설정 및 배치
        contentView.addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        // achievementGraph 설정 및 배치
        contentView.addSubview(achievementGraph)
        achievementGraph.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel).offset(-1)
            make.top.equalTo(percentLabel.snp.bottom).offset(5)
            make.height.equalTo(15)
            make.bottom.equalTo(contentView).offset(-20)
            make.width.equalTo(contentView).offset(-135 - 35)
        }

        // 동그라미들 배치
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




//class TikkleListTableViewCell: UITableViewCell {
//
//    //MARK: -TikkleListPage TableViewCell 스토리보드 요소들 연결
//    @IBOutlet weak var tikkleImage: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var percentLabel: UILabel!
//    @IBOutlet weak var graphImage: UIImageView!
//
//    @IBOutlet weak var edgeStackView: UIStackView!
//
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//}
