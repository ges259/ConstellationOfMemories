//
//  HeaderView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Properties
    // MainVC
    var mainHeaderDelegate: MainHeaderDelegate?
    
    // button image config
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
    
    
    
    // left / right button
    var leftHeaderButton: LeftHeaderButton = .mainLeftButtonTapped {
        didSet {
            // 이미지 변경
            // right 버튼 숨기기 / 보이기
            self.configButtonImage()
        }
    }
    var rightHeaderButton: RightHeaderButton = .tableRightButtonTapped
    
    
    
    // MARK: - Label
    private lazy var titleLabel: UILabel = {
        return UILabel().label(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 25)
    }()
    
    
    
    
    
    // MARK: - Button
    lazy var leftButton: UIButton = {
        let btn = UIButton()
        
        
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let image = UIImage(systemName: "line.3.horizontal",
                            withConfiguration: self.imageConfig)
            btn.setImage(image, for: .normal)
        btn.tintColor = .white
        
        
            // 버튼의 이미지 키우기
//            btn.imageEdgeInsets = UIEdgeInsets(top: 27, left: 27, bottom: 27, right: 27)
            btn.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var rightButton: UIButton = {
        let btn = UIButton(type: .custom)
        
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // fix image
        let image = UIImage(systemName: "square.and.pencil",
                            withConfiguration: self.imageConfig)
            btn.setImage(image, for: .normal)
        btn.tintColor = .white
        
            btn.addTarget(self, action: #selector(self.rightButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configure
            // background Color
            // AutoLayout
        self.configureHeaderView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - HelperFunctions
    private func configureHeaderView() {
        // background Color
        self.backgroundColor = .clear
        
        // UI - AutoLayout
        // titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 20,
                               centerX: self)
        // leftButton
        self.addSubview(self.leftButton)
        self.leftButton.anchor(leading: self.leadingAnchor, paddingLeading: 20,
                               centerY: self.titleLabel)
        // rightButton
        self.addSubview(self.rightButton)
        self.rightButton.anchor(trailing: self.trailingAnchor, paddingTrailing: 20,
                                centerY: self.titleLabel)
        // width: 50, height: 50,
    }
    
    
    

    
    
    // 버튼 이미지 바꿔주는 메서드
    // 버튼 숨기기 / 보이기
    private func configButtonImage() {
        switch leftHeaderButton {
            
        case .menuLeftButtonTapped:
            // MenuVC에서 보이는 이미지
                // back Image
            self.leftButton.setImage(UIImage(systemName: "arrowshape.backward",
                                             withConfiguration: self.imageConfig),
                                     for: .normal)
            
            
            
            
        case .mainLeftButtonTapped:
            // MainVC에서 보이는 이미지
                // menu Image
                // "line.3.horizontal"
            self.leftButton.setImage(UIImage(systemName: "line.3.horizontal",
                                             withConfiguration: self.imageConfig),
                                     for: .normal)
            // right Button은 숨기기
            self.rightButton.isHidden = true
            
            
            
            
        case .tableLeftButtonTapped:
            // TableView에서 보이는 이미지
                // back Image
            self.leftButton.setImage(UIImage(systemName: "arrowshape.backward",
                                             withConfiguration: self.imageConfig),
                                     for: .normal)
                // fix Image
            self.rightButton.setImage(UIImage(systemName: "square.and.pencil",
                                             withConfiguration: self.imageConfig),
                                     for: .normal)
            // right Button 보이게 하기
            self.rightButton.isHidden = false
            
            
            
            
            
        case .diaryLeftButtonTapped:
            // DiaryVC에서 보이는 이미지
                // share Image
            self.rightButton.setImage(UIImage(systemName: "square.and.arrow.up",
                                             withConfiguration: self.imageConfig),
                                     for: .normal)
            // left Button은 바꾸지 X
            
            
            
        }
    }
    
    
    
    
    
    
    // MARK: - Selectors
    // left Button
        // 뷰가 이동할 때 아래의 변수에 값을 할당.
            // leftHeaderButton / rightHeaderButton
                // leftButton을 누르면 변수에 따라서 다르게 작동
    @objc private func leftButtonTapped() {
        // headerView의 상태에 따라 다르게 반응
        switch leftHeaderButton {
        // 현재 보여지는 뷰 : Menu
            // MenuVC -> MainVC
        case .menuLeftButtonTapped:
            // MenuVC -> MainVC
            self.mainHeaderDelegate?.handleBackToMainVC()
            
            
            // left 버튼 용도 바꾸기 (Main으로 이동)
            self.leftHeaderButton = .mainLeftButtonTapped
            
            
            break
            
            
            
        // 현재 보여지는 뷰 : Main
            // MainVC -> MenuVC
        case .mainLeftButtonTapped:
            // 메뉴 오픈 - Delegate
            self.mainHeaderDelegate?.handleGoToMenuVC()
            
            // left 버튼 용도 바꾸기 (Menu로 이동)
            self.leftHeaderButton = .menuLeftButtonTapped
            
            // 추가 구현
                // menuVC나오게 하기
                // + calendar 없애기 (alpha값 0)
            
            break
            
            
        // 현재 보여지는 뷰 : TableView
            // TableView -> MainVC
        case .tableLeftButtonTapped:
            // MainVC 로 dismiss - Delegate
            self.mainHeaderDelegate?.handleDismiss()
            
            
            // left 버튼 용도 바꾸기 (Main으로 이동)
            self.leftHeaderButton = .mainLeftButtonTapped
            
            
            // 이미지 바꾸기
            //
            
            break
            
            
        // 현재 보여지는 뷰 : Diary
            // DiaryVC -> TableView
        case .diaryLeftButtonTapped:
            // DiaryVC 사라지기
            // *********************************8
            self.mainHeaderDelegate?.handleBackToTableView()
            
            
            // left 버튼 용도 바꾸기 (TableView로 이동)
            self.leftHeaderButton = .tableLeftButtonTapped
            
            // right 버튼 용도 바꾸기 (tableView -> DiaryVC)
            self.rightHeaderButton = .tableRightButtonTapped
            
            break
        }
    }
    
    // right Button
    @objc private func rightButtonTapped() {
        // headerView의 상태에 따라 다르게 반응
        switch rightHeaderButton {
        // 테이블뷰에서 fix버튼을 누르면
            // TableView -> DiaryVC
        case .tableRightButtonTapped:
            // 메뉴 오픈
            self.mainHeaderDelegate?.handleGoToDiaryVC()
            
            // left 버튼 용도 바꾸기 (TableView -> DiaryVC)
            self.leftHeaderButton = .diaryLeftButtonTapped
            
            // right 버튼 용도 바꾸기 (DiaryVC -> TableView)
            self.rightHeaderButton = .diaryRightButtonTapped
            
            break
            
            
            // DiaryVC에서 share버튼을 누르면
        case .diaryRightButtonTapped:
            // 메뉴 오픈
            self.mainHeaderDelegate?.handleShareButtonTapped()
            break
        }
    }

    
    
    // MARK: - API
    

    
}
