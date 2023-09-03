//
//  DiaryCollectionCell.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class DiaryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var diaryString: String? {
        didSet { self.stringLabel.text = diaryString }
    }
    
    
    func cellColor(_ color: UIColor) {
        self.borderView.layer.borderColor = color.cgColor
        self.stringLabel.textColor = color
    }
    
    
    
    // MARK: - UIView
    private lazy var borderView: UIView = {
        let view = UIView().viewConfig(backgroundColor: .clear,
                                 borderColor: UIColor.white)
        
            view.addSubview(self.stringLabel)
        self.stringLabel.anchor(centerX: view,
                                centerY: view)
        return view
    }()
    // 오늘의 추억 쓰러가기"
    private lazy var stringLabel: UILabel = {
        return UILabel().labelConfig(LabelTextColor: .white,
                                     fontName: .bold,
                                     fontSize: 27)
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // configure
            // + background Color
            // + selection Style
            // + UI - AutoLayout
        self.configureDiaryCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - HelperFunctions
    private func configureDiaryCell() {
        // background Color
        self.backgroundColor = .clear
        
        // selection Style
        self.selectionStyle = .none
        
        // UI - AutoLayout
        self.addSubview(self.borderView)
        self.borderView.anchor(top: self.topAnchor, paddingTop: 5,
                               bottom: self.bottomAnchor, paddingBottom: 5,
                               leading: self.leadingAnchor, paddingLeading: 20,
                               trailing: self.trailingAnchor, paddingTrailing: 20,
                               cornerRadius: 20)
    }
}
