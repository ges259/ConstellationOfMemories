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
        return UIView().viewConfig(backgroundColor: UIColor(white: 1, alpha: 0.3))
    }()
    
    
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "로그아웃 하시겠습니까?",
                                     fontSize: 18,
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
        return UIStackView().stackView(arrangedSubviews: [self.cancelBtn,
                                                          self.logoutBtn],
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
        
        // logoutView
        self.addSubview(self.logoutView)
        self.logoutView.anchor(width: self.frame.width,
                               height: self.frame.height,
                               cornerRadius: 20)
        // titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.logoutView.topAnchor, paddingTop: 38,
                               leading: self.logoutView.leadingAnchor,
                               trailing: self.logoutView.trailingAnchor,
                               height: 30)
        // stack_View
        self.addSubview(self.stackView)
        self.stackView.anchor(bottom: self.logoutView.bottomAnchor,
                              leading: self.logoutView.leadingAnchor,
                              trailing: self.logoutView.trailingAnchor)
    }
    
    
    // MARK: - Logout_Font
    func logoutColor(_ color: UIColor) {
        self.cancelBtn.setTitleColor(color, for: .normal)
        self.logoutBtn.setTitleColor(color, for: .normal)
        self.logoutBtn.tintColor = color
        self.titleLabel.textColor = color
    }
    
    
    
    
    
    // MARK: - Selectors
    @objc private func cancelBtnTapped() {
        self.logoutMainDelegate?.cancelBtnTapped()
    }
    
    @objc private func logoutBtnTapped() {
        self.logoutMainDelegate?.logoutBtnTapped()
    }
}
