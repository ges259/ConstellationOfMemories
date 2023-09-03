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
    
    
    
    // 셀의 타이틀 이름 바꾸기
    var setupCellTitle: SetupCelltitle?
    
    
    
    var fontColor: UIColor? {
        didSet {
            if let fontColor = self.fontColor {
                self.titleLabel.textColor = fontColor
                self.cellButton.tintColor = fontColor
                self.cellButton.setTitleColor(fontColor, for: .normal)
            }
        }
    }
    
    
    
    // MARK: - Layout
    lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "로그아웃",
                                     LabelTextColor: UIColor.nightFontColor,
                                     fontName: .system,
                                     fontSize: 20)
    }()
    
    lazy var cellButton: UIButton = {
        let btn = UIButton()
        
            btn.backgroundColor = UIColor(white: 1, alpha: 0.3)
            btn.setTitle("Logout", for: .normal)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
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
            // Button_Title_Change
                // ON -> OFF
                if self.cellButton.titleLabel?.text == "ON" {
                    print("ON")
                    Service.shared.updateInfo(on: false)
                    
                    self.cellButton.setTitle("OFF", for: .normal)
                    self.cellButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
                    self.cellButton.setTitleColor(.white, for: .normal)
                    
                    
                // OFF -> ON
                } else {
                    print("OFF")
                    Service.shared.updateInfo(on: true)
                    
                    self.cellButton.setTitle("ON", for: .normal)
                    self.cellButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
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
        self.toggleAnimate()
    }
    
    
    

    
    
    
    // MARK: - API
    
    
}
