//
//  DetailView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/18.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: - Properties
    
    
    
    
    
    
    // MARK: - Layout
    private lazy var detailBackground: UIImageView = {
        return UIImageView(image: UIImage(named: "0"))
    }()
    
    
    
    private lazy var detailTitle: UILabel = {
        return UILabel().labelConfig(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 20)
    }()
    
    private lazy var detailLeftButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 20, imageString: .menu)
    }()
    
    private lazy var detailFooterButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 20, imageString: .moon)
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
        // background Color
        self.backgroundColor = .red
        
        // alpha
        self.alpha = 0
        
        // background_Image
        self.addSubview(self.detailBackground)
        self.detailBackground.anchor(width: self.frame.width, height: self.frame.height,
                                    centerX: self, centerY: self)
        
        // titleLabel
        self.addSubview(self.detailTitle)
        self.detailTitle.anchor(top: self.detailBackground.topAnchor, paddingTop: 20,
                               centerX: self)

        // leftButton
        self.addSubview(self.detailLeftButton)
        self.detailLeftButton.anchor(leading: self.detailBackground.leadingAnchor, paddingLeading: 20,
                               centerY: self.detailTitle)

        // footerButton
        self.addSubview(self.detailFooterButton)
        self.detailFooterButton.anchor(bottom: self.detailBackground.bottomAnchor, paddingBottom: 10,
                                 centerX: self)
    }

    
    
    
    
    // MARK: - API
    
    
    
}
