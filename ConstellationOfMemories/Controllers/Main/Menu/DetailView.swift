//
//  DetailView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/18.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: - Properties
    // Font
    
    
    
    // MARK: - Layout
    lazy var detailBackground: UIImageView = {
        return UIImageView()
    }()
    
    
    
    private lazy var detailTitle: UILabel = {
        return UILabel().labelConfig(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 22)
    }()
    
    
    
    private lazy var menuButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 27, imageString: .menu)
    }()
    private lazy var footerButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 27, imageString: .moon)
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
        // alpha
        self.alpha = 0
        // background_Image
        self.addSubview(self.detailBackground)
        self.detailBackground.anchor(width: self.frame.width, height: self.frame.height,
                                     centerX: self, centerY: self,
                                     cornerRadius: 15)
        // titleLabel
        self.addSubview(self.detailTitle)
        self.detailTitle.anchor(top: self.detailBackground.topAnchor, paddingTop: 25,
                               centerX: self)
        // leftButton
        self.addSubview(self.menuButton)
        self.menuButton.anchor(leading: self.detailBackground.leadingAnchor, paddingLeading: 20,
                               centerY: self.detailTitle)
        self.menuButton.isEnabled = false
        // footerButton
        self.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.detailBackground.bottomAnchor, paddingBottom: 25,
                                 centerX: self)
        self.footerButton.isEnabled = false
    }
    
    
    // MARK: - Font_Color
    func detailColor(_ color: UIColor) {
        self.detailTitle.textColor = color
        self.menuButton.tintColor = color
        self.footerButton.tintColor = color
    }
}
