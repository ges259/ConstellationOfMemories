//
//  DiaryCollectionHeaderView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class DiaryCollectionHeaderView: UIView {
    
    // MARK: - Properties
    
    // DiaryCollectionVC
    var delegate: DiaryCollectionVCDelegate?
    
    
    // MARK: - Label
    private lazy var titleLabel: UILabel = {
        return UILabel().label(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 25)
    }()
    
    
    // MARK: - Button
    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .custom)
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
            btn.setImage(#imageLiteral(resourceName: "baseline_clear_white_36pt_2x").withRenderingMode(.alwaysOriginal), for: .normal)
            btn.contentMode = .scaleAspectFit
            // 버튼의 이미지 키우기
            btn.imageEdgeInsets = UIEdgeInsets(top: 27, left: 27, bottom: 27, right: 27)
            btn.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configure
            // background Color
            // AutoLayout
        self.configureHeaderView()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - HelperFunctions
    private func configureHeaderView() {
        // background Color
        self.backgroundColor = .systemGray5
        
        // UI - AutoLayout
        // backButton
        self.addSubview(self.backButton)
        self.backButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 25,
                               leading: self.leadingAnchor, paddingLeading: 20)
        // titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 25,
                               centerX: self)
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func backButtonTapped() {
        self.delegate?.handleDismiss()
    }
    
    
    
    // MARK: - API
    

    
}
