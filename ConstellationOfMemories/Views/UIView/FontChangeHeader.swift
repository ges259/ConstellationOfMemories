//
//  FontChangeHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class FontChangeTableHeader: UIView {
    
    // MARK: - Properties
    
    // enum으로 교체
    var configureView: String? {
        didSet {
            // backgroundImage 바꾸기
            
            // titleLabel 글자 색 바꾸기
            
            // leftButton / fotterButton tint 색 바꾸기
            
        }
    }
    
    
    
    
    
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
        
        self.configureHeader()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper Functions
    private func configureHeader() {
        // 기본 backgroundColor
        self.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        
        let width = (self.frame.width - 100) / 2
        let height = width / 10 * 16
        // background_Image
        self.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(width: width, height: height,
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
}
