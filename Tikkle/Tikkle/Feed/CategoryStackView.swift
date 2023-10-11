//
//  CategoryStackView.swift
//  Tikkle
//
//  Created by 김도현 on 2023/10/10.
//

import UIKit

class CategoryStackView: UIStackView {

    private let uniqueChallenge: UIButton = {
        let button = UIButton()
        button.setTitle("이색도전", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return button
    }()
    private let selfImprovementButton: UIButton = {
        let button = UIButton()
        button.setTitle("자기계발", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return button
    }()
    private let challenge30Button: UIButton = {
        let button = UIButton()
        button.setTitle("도전 30일", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return button
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        return view
    }()
    var selectIndex: Int = 0 {
        didSet {
            moveLine()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }

}

private extension CategoryStackView {
    func setup() {
        initSetup()
        addViews()
        autoLayoutSetup()
        buttonSetup()
    }
    func initSetup() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 8
    }
    func addViews() {
        addArrangedSubview(uniqueChallenge)
        addArrangedSubview(selfImprovementButton)
        addArrangedSubview(challenge30Button)
        addSubview(lineView)
    }
    func autoLayoutSetup() {
        lineView.snp.makeConstraints { make in
            make.width.equalTo(uniqueChallenge.snp.width).multipliedBy(0.5)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(uniqueChallenge)
        }
    }
    func buttonSetup() {
        uniqueChallenge.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        selfImprovementButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        challenge30Button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    @objc func buttonClick(button: UIButton) {
        for index in 0..<arrangedSubviews.count {
            if arrangedSubviews[index] == button { selectIndex = index }
        }
    }
    func moveLine() {
        let selectedView = arrangedSubviews[selectIndex]
        lineView.snp.remakeConstraints { make in
            make.width.equalTo(uniqueChallenge.snp.width).multipliedBy(0.5)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(selectedView)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
