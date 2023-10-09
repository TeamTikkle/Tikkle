//
//  InfoCell.swift
//  Practice_tikkle
//
//  Created by 김지훈 on 2023/09/14.
//

import UIKit
import SnapKit

class InfoCell: UITableViewCell {
    static let identifier = "Infocell"
    
    lazy var infoMenuTitle: UILabel = {
        let infoMenuTitle = UILabel()
        infoMenuTitle.font = .systemFont(ofSize: 16, weight: .regular)
        return infoMenuTitle
    }()
    
    lazy var versionText: UILabel = {
        let versionText = UILabel()
        versionText.font = .systemFont(ofSize: 16, weight: .regular)
        return versionText
    }()
    
    func infoCellPrint() {
        contentView.addSubview(infoMenuTitle)
        contentView.addSubview(versionText)
        
        infoMenuTitle.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
        }
        
        versionText.snp.makeConstraints { make in
            make.trailing.equalTo(self.contentView).offset(-20)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        infoCellPrint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
