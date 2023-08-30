//
//  MenuVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class MenuVC: UIView {
    
    // MARK: - Properties
    var mainMenuDelegate: MenuMainDelegate?
    
    
    
    
    // MARK: - Button
    
    // 달성률
    private lazy var achievementButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let btn = UIButton().buttonSustemImage(btnSize: 32, imageString: .achievement)
            btn.addTarget(self, action: #selector(self.achievementButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    // home
    private lazy var homeButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let btn = UIButton().buttonSustemImage(btnSize: 32, imageString: .home)
            btn.addTarget(self, action: #selector(self.homeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    // 상점
    private lazy var shopButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let btn = UIButton().buttonSustemImage(btnSize: 32, imageString: .shop)
            btn.addTarget(self, action: #selector(self.shopButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    // 설정
    private lazy var setupButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let btn = UIButton().buttonSustemImage(btnSize: 32, imageString: .setup)
            btn.addTarget(self, action: #selector(self.setupButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        // configure
            // background
        self.configureMenuVC()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    
    // MARK: - HelperFunctions
    private func configureMenuVC() {
        // background Color
        self.backgroundColor = .clear
//        self.backgroundColor = .red
        
        
        // UI - AutoLayout
        self.addSubview(self.achievementButton)
        self.achievementButton.anchor(top: self.topAnchor,
                                      leading: self.leadingAnchor,
                                      trailing: self.trailingAnchor,
                                      height: 75)
        
        self.addSubview(self.homeButton)
        self.homeButton.anchor(top: self.achievementButton.bottomAnchor,
                               leading: self.leadingAnchor,
                               trailing: self.trailingAnchor,
                               height: 75)
        
        
        self.addSubview(self.shopButton)
        self.shopButton.anchor(top: self.homeButton.bottomAnchor,
                               leading: self.leadingAnchor,
                               trailing: self.trailingAnchor,
                               height: 75)
        
        
        self.addSubview(self.setupButton)
        self.setupButton.anchor(top: self.shopButton.bottomAnchor,
                                leading: self.leadingAnchor,
                                trailing: self.trailingAnchor,
                                height: 75)
    }
    
    
    
    // MARK: - Selectors
    @objc private func achievementButtonTapped() {
        self.mainMenuDelegate?.handleAchievement()
    }
    @objc private func homeButtonTapped() {
        self.mainMenuDelegate?.handleHome()
    }
    @objc private func shopButtonTapped() {
        self.mainMenuDelegate?.handleShop()
    }
    @objc private func setupButtonTapped() {
        self.mainMenuDelegate?.handleSetup()
    }
    
    
    
    
    
    
    // MARK: - API
    
    
    
    
    
}
