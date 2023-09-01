//
//  HomeSecondCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/29.
//

import UIKit

final class HomeFirstCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    
    lazy var haveImage: UIImageView = {
        return UIImageView()
    }()
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.haveImage)
        self.haveImage.anchor(top: self.topAnchor,
                              bottom: self.bottomAnchor,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor,
                              cornerRadius: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    // MARK: - Helper Functions
    
    
    
}

