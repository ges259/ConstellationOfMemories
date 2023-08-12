//
//  SetupTableViewCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/11.
//

import UIKit

final class SetupTableviewCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    
    
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
//        self.backgroundColor = .clear
        self.backgroundColor = .red
        // Selection Style
        self.selectionStyle = .none
    }
    
    
    
    // MARK: - API
    
    
}
