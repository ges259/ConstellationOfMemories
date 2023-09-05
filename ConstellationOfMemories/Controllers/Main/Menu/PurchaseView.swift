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
            self.configTitle(black: true)
            self.coinLabel.text = "코인 10개 필요, 현재 코인 \(self.coin)개"
        }
    }
    
    
    // MARK: - Layout
    private lazy var logoutView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor(white: 1, alpha: 0.75))
    }()
    
    
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "구매하시겠습니까?",
                                     LabelTextColor: .black,
                                     fontSize: 18,
                                     textAlignment: .center)
    }()
    private lazy var coinLabel: UILabel = {
        return UILabel().labelConfig(fontSize: 12,
                                     textAlignment: .center)
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton().authButton(title: "취소",
                                        titleColor: .darkGray,
                                        backgroundColor: .clear)
            btn.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var logoutBtn: UIButton = {
        let btn = UIButton().authButton(title: "구매",
                                        titleColor: .darkGray,
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
        // coinLabel
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
    
    
    
    private func configTitle(black: Bool) {
        if black == true {
            self.titleLabel.text = "구매하시겠습니까?"
            self.titleLabel.textColor = .black
            
        } else {
            self.titleLabel.text = "코인 \(10 - self.coin)개 부족"
            self.titleLabel.textColor = .red
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func cancelTapped() {
        self.purchaseMainDelegate?.cancelTapped()
    }
    
    @objc private func purchaseTapped() {
        // 구매에 성공했다면 ( 돈이 있다면 )
        if self.coin >= 10 {
            self.purchaseMainDelegate?.purchaseTapped()
            
        // 코인 부족으로 -> 구매에 실패했다면
        } else { self.configTitle(black: false) }
    }
}
