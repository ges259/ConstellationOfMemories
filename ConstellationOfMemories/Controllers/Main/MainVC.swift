//
//  MainVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import UIKit

// 나중에 햄버거 메뉴 만들기
    // ContainerVC
final class MainVC: UIViewController {
    
    // MARK: - Properties
    
    
    
    
    
    
    // MARK: - Button
    private lazy var calendarButton: UIButton = {
        let btn = UIButton()
        // 버튼 시스템 이미지 크기 바꾸기
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .default)
        let largeBoldDoc = UIImage(systemName: "calendar", withConfiguration: largeConfig)
            btn.setImage(largeBoldDoc, for: .normal)
        
            btn.tintColor = .black
        
            btn.addTarget(self, action: #selector(self.calendarButtonTapped), for: .touchUpInside)
        return btn
    }()
    // baseline_menu_black_36dp
    private lazy var menuButton: UIButton = {
        let btn = UIButton()
            btn.setImage(UIImage(named: "baseline_menu_black_36dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure
            // backgroundColor
            // UI - AutoLayout
        self.configureMainVC()
    }
    
    
    
    // MARK: - Helper Functions
    private func configureMainVC() {
        // background Color
        self.view.backgroundColor = .white
        
        // UI - AutoLayout
        self.view.addSubview(self.calendarButton)
        self.calendarButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 5,
                                   centerX: self.view)
    }
    
    
    
    // MARK: - Selectors
    @objc private func calendarButtonTapped() {
        let diaryCollectionVC = DiaryCollectionVC()
        diaryCollectionVC.modalPresentationStyle = .fullScreen
        self.present(diaryCollectionVC, animated: true)
    }
    

    // MARK: - API
    
    
    
}
