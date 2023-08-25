//
//  SetupTableViewCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/11.
//

import UIKit

final class SetupTableviewCell: UITableViewCell {
    
    // MARK: - Properties
    var setupCellSetupDelegate: SetupCellSetupDelegate?
    
    
    private var inforToggle: Bool = false {
        didSet { self.toggleAnimate() }
    }
    
    // 셀의 타이틀 이름 바꾸기
    var setupCellTitle: SetupCelltitle? {
        didSet {
            if self.setupCellTitle == .info {
                // titleLabel 바꾸기
                self.titleLabel.text = "알림"
                
                
                
                // 버튼 바꾸기
                // DB에서 가져와야 함
                // MARK: - Fix
                // 일단 임시방편
                self.cellButton.setTitle("On", for: .normal)
                
                
            } else {
                // titleLabel 바꾸기
                self.titleLabel.text = "로그아웃"
                
                // 버튼 바꾸기
                self.cellButton.setTitle("logout", for: .normal)
            }
        }
    }
    
    
    
    // MARK: - Layout
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(LabelTextColor: UIColor.nightFontColor,
                                     fontName: .system,
                                     fontSize: 20)
    }()
    
    private lazy var cellButton: UIButton = {
        let btn = UIButton()
        
            btn.backgroundColor = UIColor(white: 1, alpha: 0.3)
            btn.setTitle("OFF", for: .normal)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.font = .systemFont(ofSize: 16)
        
            btn.addTarget(self, action: #selector(self.toggleButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    // MARK: - LifeCyel
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // config Cell
        self.configureCell()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    private func configureCell() {
        // background Color
        self.backgroundColor = .clear

        // Selection Style
        self.selectionStyle = .none
        
        // configure UI
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(leading: self.leadingAnchor, paddingLeading: 20,
                               centerY: self)
        
        // toggleButton
        self.contentView.addSubview(self.cellButton)
        self.cellButton.anchor(trailing: self.trailingAnchor, paddingTrailing: 20,
                                 width: 100, height: 35,
                                 centerY: self,
                                 cornerRadius: 10)
    }
    
    private func toggleAnimate() {
        
        // 알림 On / Off 버튼을 눌렀을 경우
        if self.setupCellTitle == .info {
            UIView.animate(withDuration: 0.3) {
                self.cellButton.alpha = 0
                
            } completion: { _ in
                if self.inforToggle == true {
                    self.cellButton.setTitle("ON", for: .normal)
                    self.cellButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
                    self.cellButton.setTitleColor(.white, for: .normal)
                    
                } else {
                    self.cellButton.setTitle("OFF", for: .normal)
                    self.cellButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
                    self.cellButton.setTitleColor(.white, for: .normal)
                }
                
                UIView.animate(withDuration: 0.3) {
                    self.cellButton.alpha = 1
                }
            }
            
            
            
            
            
        // 로그아웃 버튼을 눌렀을 경우
        } else {
            // 새로운 뷰 (+ 블랙 뷰)
            self.setupCellSetupDelegate?.logoutBtnTapped()
        }
    }
    
    
    
    
    // MARK: - Selectors
    @objc private func toggleButtonTapped() {
        self.inforToggle.toggle()
    }
    
    
    

    
    
    
    // MARK: - API
    
    
}
