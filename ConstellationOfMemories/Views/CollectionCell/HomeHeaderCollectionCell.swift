//
//  HomeHeaderCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class HomeHeaderCollectionCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    
    
    
    
    // MARK: - Layout
    private let backgroundImage: UIImageView = {
        return UIImageView(image: UIImage(named: "blueSky"))
    }()
    
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 13)
    }()
    
    private lazy var leftButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 13, imageString: .menu)
    }()
    
    private lazy var footerButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 15, imageString: .moon)
    }()
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        self.backgroundColor = .red

        // background_Image
        self.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(width: self.frame.width, height: self.frame.height,
                                    centerX: self, centerY: self)
        
        // titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.backgroundImage.topAnchor, paddingTop: 20,
                               centerX: self)

        // leftButton
        self.addSubview(self.leftButton)
        self.leftButton.anchor(leading: self.backgroundImage.leadingAnchor, paddingLeading: 20,
                               centerY: self.titleLabel)

        // footerButton
        self.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.backgroundImage.bottomAnchor, paddingBottom: 10,
                                 centerX: self)
    }
    
    
    
    // MARK: - API
    
    
}










