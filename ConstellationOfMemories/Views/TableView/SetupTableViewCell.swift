//
//  SetupTableViewCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/11.
//

import UIKit

final class SetupTableviewCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    
    
    
    // MARK: - Layout
    lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "11",
                                     LabelTextColor: UIColor.nightFontColor,
                                     fontName: .system,
                                     fontSize: 20)
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
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    // MARK: - Helper Functions
    private func configureCell() {
//         background Color
        self.backgroundColor = .clear
//        self.backgroundColor = .red
        
        
        
        // Selection Style
        self.selectionStyle = .none
        
        
        // configure UI
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(leading: self.leadingAnchor, paddingLeading: 20,
                               centerY: self)
    }
    
    
    
    // MARK: - API
    
    
}
