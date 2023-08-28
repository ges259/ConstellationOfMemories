//
//  HomeHeaderCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class HomeHeaderCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    // segement마다 다른 배경화면 설정
    var imgString: String = "dawn1" {
        didSet { self.backgroundImage.image = UIImage(named: imgString) }
    }
    
    
    
    // 셀마다 각각 다른 Layout 설정
    var collectionUI: Int = 0 {
        didSet {
            switch collectionUI {
            case 0: self.mainUI()
            case 1: self.diaryTableUI()
            case 2: self.diaryViewUI()
            default: break
            }
        }
    }
    
    
    
    // MARK: - Layout
    private let backgroundImage: UIImageView = {
        return UIImageView()
    }()
    
    
    
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 10)
    }()
    
    
    
    private lazy var leftButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .menu)
    }()
    private lazy var backButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .back)
    }()
    
    private lazy var footerButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .moon)
    }()
    
    
    
    private lazy var diaryTable1: UILabel = {
        return UILabel().homeMiniDiary(title: "오늘 떠올린 추억")
    }()
    private lazy var diaryTable2: UILabel = {
        return UILabel().homeMiniDiary(title: "어제 떠올린 추억")
    }()
    private lazy var diaryTable3: UILabel = {
        return UILabel().homeMiniDiary(title: "그저께 떠올린 추억")
    }()
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        // background_Image
        self.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(width: self.frame.width, height: self.frame.height,
                                    centerX: self, centerY: self)
        // titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.backgroundImage.topAnchor, paddingTop: 10,
                               centerX: self)
    }
    
    
    
    
    
    private func mainUI() {
        // leftButton
        self.addSubview(self.leftButton)
        self.leftButton.anchor(leading: self.backgroundImage.leadingAnchor, paddingLeading: 10,
                               centerY: self.titleLabel)
        // footerButton
        self.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.backgroundImage.bottomAnchor, paddingBottom: 10,
                                 centerX: self)
    }
    
    
    private func diaryTableUI() {
        // title
        self.titleLabel.text = "일기 목록"
        // left_Button
        self.addSubview(self.backButton)
        self.backButton.anchor(leading: self.backgroundImage.leadingAnchor, paddingLeading: 10,
                               centerY: self.titleLabel)
        
        // diary_Table_1
        self.addSubview(self.diaryTable1)
        self.diaryTable1.anchor(top: self.titleLabel.bottomAnchor, paddingTop: 10,
                                leading: self.leadingAnchor, paddingLeading: 10,
                                trailing: self.trailingAnchor, paddingTrailing: 10,
                                height: 30)
        // diary_Table_2
        self.addSubview(self.diaryTable2)
        self.diaryTable2.anchor(top: self.diaryTable1.bottomAnchor, paddingTop: 5,
                                leading: self.leadingAnchor, paddingLeading: 10,
                                trailing: self.trailingAnchor, paddingTrailing: 10,
                                height: 30)
        // diary_Table_3
        self.addSubview(self.diaryTable3)
        self.diaryTable3.anchor(top: self.diaryTable2.bottomAnchor, paddingTop: 5,
                                leading: self.leadingAnchor, paddingLeading: 10,
                                trailing: self.trailingAnchor, paddingTrailing: 10,
                                height: 30)
    }
    
    
    private func diaryViewUI() {
        // title
        self.titleLabel.text = "일기 목록"
        // left_Button
        self.addSubview(self.backButton)
        self.backButton.anchor(leading: self.backgroundImage.leadingAnchor, paddingLeading: 10,
                               centerY: self.titleLabel)
        
        // footer_Button
//        self.footerButton.setImage(.setImg(.share), for: .normal)
        // UIView
        
    }
    
    
    
    
    
    
    
    
    // MARK: - API
    
    
}










