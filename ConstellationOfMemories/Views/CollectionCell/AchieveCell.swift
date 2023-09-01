//
//  AchieveFirstCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class AchieveCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var haveImage: UIImageView = {
        return UIImageView()
    }()
    
    lazy var monthString: UILabel = {
        return UILabel().labelConfig(LabelTextColor: .white, fontSize: 38)
    }()
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(self.haveImage)
        self.haveImage.anchor(top: self.topAnchor,
                              bottom: self.bottomAnchor,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor,
                              cornerRadius: 20)
        self.addSubview(self.monthString)
        self.monthString.anchor(centerX: self, centerY: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
