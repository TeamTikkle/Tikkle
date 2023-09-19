//
//  ThisMonthTikkleHeaderView.swift
//  Tikkle
//
//  Created by 김도현 on 2023/09/18.
//

import UIKit
import SnapKit

class ThisMonthTikkleHeaderView: UICollectionReusableView, Reusable {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    private var hotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hot", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이달의\n티클시트 모음"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .systemGray5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension ThisMonthTikkleHeaderView {
    func setup() {
        addViews()
        autoLayoutSetup()
    }
    
    func addViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(hotButton)
        mainStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(moreLabel)
    }
    
    func autoLayoutSetup() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(14)
        }
        labelStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
}
