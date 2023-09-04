//
//  PurchaseView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/09/04.
//

import UIKit

final class PurchaseView: UIView {
    
    // MARK: - Properties
    // Delegate
    var purchaseMainDelegate: PurchaseMainDelegate?
    
    var coin: Int = 0 {
        didSet {
            self.coinLabel.text = "코인 10개 필요, 현재 코인 \(self.coin)개"
        }
    }
    
    
    // MARK: - Layout
    private lazy var logoutView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor(white: 1, alpha: 0.75))
    }()
    
    
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "구매하시겠습니까?",
                                     fontSize: 18,
                                     textAlignment: .center)
    }()
    private lazy var coinLabel: UILabel = {
        return UILabel().labelConfig(fontSize: 12,
                                     textAlignment: .center)
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton().authButton(title: "취소",
                                        backgroundColor: .clear)
            btn.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton().authButton(title: "구매",
                                        backgroundColor: .clear)
        btn.addTarget(self, action: #selector(self.purchaseTapped), for: .touchUpInside)
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
    
    
    
    
    // MARK: - Helper_Functions
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
        self.titleLabel.anchor(top: self.logoutView.topAnchor, paddingTop: 12,
                               leading: self.logoutView.leadingAnchor,
                               trailing: self.logoutView.trailingAnchor,
                               height: 30)
        
        self.addSubview(self.coinLabel)
        self.coinLabel.anchor(top: self.titleLabel.bottomAnchor,
                              leading: self.titleLabel.leadingAnchor,
                              trailing: self.titleLabel.trailingAnchor)
        // stack_View
        self.addSubview(self.stackView)
        self.stackView.anchor(bottom: self.logoutView.bottomAnchor,
                              leading: self.logoutView.leadingAnchor,
                              trailing: self.logoutView.trailingAnchor)
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func cancelTapped() {
        self.purchaseMainDelegate?.cancelTapped()
    }
    
    @objc private func purchaseTapped() {
        self.purchaseMainDelegate?.purchaseTapped()
    }
}
