//
//  UserInfoHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/11.
//

import UIKit

final class UserInfoHeader: UIView {
    
    // MARK: - Properties
    
    
    
    
    
    
    // MARK: - View
    private lazy var profileView: UIImageView = {
        let img = UIImageView(image: UIImage.setImg(.person, pointSize: 40))
        
        img.tintColor = .white
        return img
    }()


    // MARK: - Label
    private lazy var fullNameLabel: UILabel = {
        return UILabel().labelConfig(labelText: "계은성",
                                     LabelTextColor: .white,
                                     fontName: .system,
                                     fontSize: 16)
    }()
    private lazy var emailLabel: UILabel = {
        return UILabel().labelConfig(labelText: "chwl0571@daum.net",
                                     LabelTextColor: .white,
                                     fontName: .system,
                                     fontSize: 13)
    }()

    
    // MARK: - StackView
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [self.fullNameLabel,
                                                          self.emailLabel],
                                       axis: .vertical,
                                       distribution: .fillEqually)
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
        // background Color
        
        // profileView
        self.addSubview(self.profileView)
        self.profileView.anchor(leading: self.leadingAnchor, paddingLeading: 20,
                                centerY: self)
        
        
        // initialLabel
        self.addSubview(self.stackView)
        self.stackView.anchor(top: self.profileView.topAnchor,
                              bottom: self.profileView.bottomAnchor,
                              leading: self.profileView.trailingAnchor, paddingLeading: 10)
        
        
    }
    
    
    
    // MARK: - Selectors
    
    
    
    
    // MARK: - API
    
    
    
}
