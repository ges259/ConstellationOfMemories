//
//  SetupTableViewCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/11.
//

import UIKit

final class SetupTableviewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var inforToggle: Bool = false {
        didSet {
            self.toggleAnimate()
        }
    }
    
    
    
    // MARK: - Layout
    lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "11",
                                     LabelTextColor: UIColor.nightFontColor,
                                     fontName: .system,
                                     fontSize: 20)
    }()
    
    private lazy var inforButton: UIButton = {
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
        self.contentView.addSubview(self.inforButton)
        self.inforButton.anchor(trailing: self.trailingAnchor, paddingTrailing: 20,
                                 width: 50, height: 35,
                                 centerY: self,
                                 cornerRadius: 10)
    }
    
    private func toggleAnimate() {
        
        UIView.animate(withDuration: 0.3) {
            self.inforButton.alpha = 0
            
            
        } completion: { _ in
            if self.inforToggle == true {
                self.inforButton.setTitle("ON", for: .normal)
                self.inforButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
                self.inforButton.setTitleColor(.white, for: .normal)
                
            } else {
                self.inforButton.setTitle("OFF", for: .normal)
                self.inforButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
                self.inforButton.setTitleColor(.white, for: .normal)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.inforButton.alpha = 1
            }
        }
    }
    
    
    
    
    // MARK: - Selectors
    @objc private func toggleButtonTapped() {
        self.inforToggle.toggle()
    }
    
    
    

    
    
    
    // MARK: - API
    
    
}
