//
//  UserInfoHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/11.
//

import UIKit

final class SetupHeaderView: UIView {
    
    // MARK: - View
    private lazy var profileView: UILabel = {
        return UILabel().labelConfig(LabelTextColor: .white,
                                        fontName: .bold,
                                        fontSize: 20,
                                        textAlignment: .center)
    }()


    // MARK: - Label
    private lazy var fullNameLabel: UILabel = {
        return UILabel().labelConfig(LabelTextColor: .white,
                                     fontName: .system,
                                     fontSize: 16)
    }()
    private lazy var emailLabel: UILabel = {
        return UILabel().labelConfig(LabelTextColor: .white,
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
        self.backgroundColor = .clear
        // profileView
        self.addSubview(self.profileView)
        self.profileView.anchor(leading: self.leadingAnchor, paddingLeading: 20,
                                width: 40, height: 40,
                                centerY: self,
                                cornerRadius: self.profileView.frame.width / 2)
        // initialLabel
        self.addSubview(self.stackView)
        self.stackView.anchor(top: self.profileView.topAnchor,
                              bottom: self.profileView.bottomAnchor,
                              leading: self.profileView.trailingAnchor, paddingLeading: 10)
    }
}










// MARK: - SetupInfoHeaderDelegate
extension SetupHeaderView: SetupInfoHeaderDelegate {
    func configInfoHeader(user: User?) {
        guard let user = user else { return }
        
        self.fullNameLabel.text = user.fullName
        self.emailLabel.text = user.email
        self.profileView.text = user.firstInitial
    }
}
