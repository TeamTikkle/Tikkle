//
//  HorizontalCollectionViewCell.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/16.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "\(HorizontalCollectionViewCell.self)"
    private let recommendCollectionView: UICollectionView = {
        let flow = CarouselLayout()
        flow.itemSize = CGSize(width: 280.0, height: 444.0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.backgroundColor = .clear
        return cv
    }()
    weak var delegate: ViewControllerPushDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(recommendCollectionView)
        
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        recommendCollectionView.register(ThisMonthTikkleCollectionViewCell.self, forCellWithReuseIdentifier: ThisMonthTikkleCollectionViewCell.identifier)
        
        recommendCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recommendCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recommendCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recommendCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recommendCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recommendCollectionView.heightAnchor.constraint(equalToConstant: 444).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HorizontalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThisMonthTikkleCollectionViewCell.identifier, for: indexPath) as? ThisMonthTikkleCollectionViewCell else { return UICollectionViewCell() }
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        cell.tikkle = DataList.list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate else { return }
        delegate.pushViewController(tikkle: DataList.list[indexPath.item])
    }
}
