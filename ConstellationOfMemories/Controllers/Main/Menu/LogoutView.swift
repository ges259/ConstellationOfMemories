//
//  LogoutView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/22.
//

import UIKit

final class LogoutView: UIView {
    
    // MARK: - Properties
    var logoutMainDelegate: LogoutMainDelegate?
    
    
    
    
    
    

    
    // MARK: - Layout
    private lazy var logoutView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor(white: 1, alpha: 0.75))
    }()
    
    
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "로그아웃 하시겠습니까?",
                                     fontSize: 15,
                                     textAlignment: .center)
    }()
    
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton().authButton(title: "취소",
                                        backgroundColor: .clear)
        
        btn.addTarget(self, action: #selector(self.cancelBtnTapped), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton().authButton(title: "로그아웃",
                                        backgroundColor: .clear)
        
        btn.addTarget(self, action: #selector(self.logoutBtnTapped), for: .touchUpInside)
        
        return btn
    }()
    
    
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [cancelBtn, logoutBtn],
                                       axis: .horizontal,
                                       spacing: 0,
                                       alignment: .center,
                                       distribution: .fillEqually)
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
        // alpha = 0
        self.alpha = 0
        // backgorund Color
        self.backgroundColor = UIColor.clear
        
        // logoutView
        self.addSubview(self.logoutView)
        self.logoutView.anchor(width: self.frame.width,
                               height: self.frame.height,
                               cornerRadius: 20)
        
        
        // titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.logoutView.topAnchor, paddingTop: 20,
                               leading: self.logoutView.leadingAnchor,
                               trailing: self.logoutView.trailingAnchor,
                               height: 30)
        
        // stack_View
        self.addSubview(self.stackView)
        self.stackView.anchor(bottom: self.logoutView.bottomAnchor,
                              leading: self.logoutView.leadingAnchor,
                              trailing: self.logoutView.trailingAnchor)
    }
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func cancelBtnTapped() {
        self.logoutMainDelegate?.cancelBtnTapped()
    }
    
    @objc private func logoutBtnTapped() {
        self.logoutMainDelegate?.logoutBtnTapped()
    }
}
