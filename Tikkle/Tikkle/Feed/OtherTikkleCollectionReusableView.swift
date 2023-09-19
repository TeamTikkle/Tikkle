//
//  OutherTikkleCollectionReusableView.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/16.
//

import UIKit

class OtherTikkleCollectionReusableView: UICollectionReusableView {
    static let identifier: String = "\(OtherTikkleCollectionReusableView.self)"
    
    private lazy var otherStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [otherTikkleTitleLabel, otherSubTitleLabel])
        st.axis = .vertical
        st.alignment = .leading
        st.distribution = .fillProportionally
        st.spacing = -16
        return st
    }()
    private let otherTikkleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테도리별로 둘러보기"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        return label
    }()
    private let otherSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "만들어진 티끌시트 템플릿을 활용해보세요!"
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textColor = UIColor.subTitleColor
        return label
    }()
    private let margin: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OtherTikkleCollectionReusableView {
    func setup() {
        addViews()
        autoLayoutSetup()
    }
    
    func addViews() {
        addSubview(otherStackView)
    }
    
    func autoLayoutSetup() {
        otherStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(margin)
        }
    }
}
