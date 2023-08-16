//
//  AdditionalCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/15.
//

import UIKit

final class FontChangeCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    var selectedTime: String? {
        didSet {
            
        }
    }
    
    
    
    
    // MARK: - Layout
    lazy var additionalLabel: UILabel = {
        return UILabel().labelConfig(labelText: "11",
                                     LabelTextColor: UIColor.nightFontColor,
                                     fontName: .system,
                                     fontSize: 20)
    }()
    
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // configure UI
        self.addSubview(self.additionalLabel)
        self.additionalLabel.anchor(leading: self.leadingAnchor, paddingLeading: 20,
                                    centerY: self)
    }
    
    
    
    
    // MARK: - API
    
    
    
}
