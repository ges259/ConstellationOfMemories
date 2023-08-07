//
//  DiaryCollectionCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class DiaryCollectionCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    
    
    
    
    // MARK: - UIView
    private lazy var borderView: UIView = {
        let view = UIView()
            view.backgroundColor = .clear
        
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 3
        
            view.addSubview(self.stringLabel)
        stringLabel.anchor(centerX: view,
                           centerY: view)
        return view
    }()
    // 오늘의 추억 쓰러가기"
    private lazy var stringLabel: UILabel = {
        return UILabel().label(labelText: "8월 6일에 떠올린 추억",
                               LabelTextColor: .white,
                               fontName: .bold,
                               fontSize: 27)
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureDiaryCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
//    }
    
    
    
    // MARK: - HelperFunctions
    private func configureDiaryCell() {
        // background Color
        self.backgroundColor = .systemGray5
        
        // selection Style
        self.selectionStyle = .none
        
        
        // UI - Auto-Layout
        self.addSubview(self.borderView)
        self.borderView.anchor(top: self.topAnchor, paddingTop: 5,
                               bottom: self.bottomAnchor, paddingBottom: 8,
                               leading: self.leadingAnchor, paddingLeading: 5,
                               trailing: self.trailingAnchor, paddingTrailing: 16,
                               cornerRadius: 10)
        
        
    }
    
    
    
    // MARK: - Selectors
    
    
    
    
    
    
    
    // MARK: - API
    
    
}
