//
//  DiaryVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class DiaryVC: UIView {
    
    // MARK: - Properties
    // 싱글톤
    private let headerView = HeaderView.shared
    
    
    
    
    // MARK: - View
        // separator_View
    private lazy var separatorView: UIView = {
        let view = UIView()
            view.backgroundColor = .white
        return view
    }()
    
    
    
    // MARK: - TextView
    lazy var diaryTextView: UITextView = {
        let tv = UITextView()
            tv.backgroundColor = UIColor.clear
            tv.font = UIFont.systemFont(ofSize: 16)
            tv.textColor = .white
            tv.isEditable = false
        return tv
    }()
    
    
    
    // MARK: - Label
    lazy var diaryLabel: UILabel = {
        let lbl = UILabel().label(labelText: "오늘의 하루는 어땠나요?",
                                  LabelTextColor: .white,
                                  fontName: .bold,
                                  fontSize: 25,
                                  numberOfLines: 0,
                                  textAlignment: .center)
        return lbl
    }()
    
    
    
    // MARK: - Button
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 31, imageString: .share)
            btn.addTarget(self, action: #selector(self.shareButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    // MARK: - LifeCycle    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // configure
            // background Color
            // Auto-Layout
        self.configureDiaryVC()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - HelperFunctions
    private func configureDiaryVC() {
        // background Color
        self.backgroundColor = .clear
        
        // UI - AutoLayout
        // diaryLabel
        self.addSubview(self.diaryLabel)
        self.diaryLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 20,
                               leading: self.leadingAnchor, paddingLeading: 20,
                               trailing: self.trailingAnchor, paddingTrailing: 20,
                               height: 90)
        // separatorView
        self.addSubview(self.separatorView)
        self.separatorView.anchor(top: self.diaryLabel.bottomAnchor, paddingTop: 10,
                                  leading: self.diaryLabel.leadingAnchor,
                                  trailing: self.diaryLabel.trailingAnchor,
                                  height: 3)
        // diaryTextView
        self.addSubview(self.diaryTextView)
        self.diaryTextView.anchor(top: self.separatorView.bottomAnchor, paddingTop: 10,
                                  leading: self.diaryLabel.leadingAnchor,
                                  trailing: self.diaryLabel.trailingAnchor,
                                  height: 200,
                                  cornerRadius: 20)
        
        // footerButton
        self.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                   centerX: self)
    }
    
    
    
    // MARK: - Selectors
    @objc private func shareButtonTapped() {
        print(#function)
    }
    
    
    
    
    // MARK: - API
    
    
    
    
    
}
/*
 수정상태 == true
    텍스트뷰를 변경가능하고,
    텍스트뷰 색이 진하게 (보이게)
    공유버튼이 사라지고
 
 
 저장 상태에서는 == false
    텍스트뷰 변경이 불가능하고,
    텍스트뷰 색이 .clear로 변함
    공유버튼이 수정버튼이 되고
 */

// MARK: - DiaryHeaderDelegate
extension DiaryVC: DiaryHeaderDelegate {
    func buttonImageChange(fix: Bool) {
        // 수정뷰
        if fix == true {
            UIView.animate(withDuration: 0.3) {
                self.diaryTextView.isEditable = true
                self.diaryTextView.backgroundColor = .systemGray5
                self.footerButton.alpha = 0
            }
            
            
        // 저장뷰
        } else {
            UIView.animate(withDuration: 0.3) {
                self.diaryTextView.isEditable = false
                self.diaryTextView.backgroundColor = .clear
                self.footerButton.alpha = 1
            }
        }
    }
}

