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
    // DiaryVC
    var diaryHeaderDelegate: DiaryHeaderDelegate?
    
    // 싱글톤
    static let shared = HeaderView()
    
    // Fix Or Save (diaryFixOrSave)
    private var fixToggle: Bool = true
    
    
    // 버튼의 이미지,
    // 버튼의 역할
    var buttonConfig: LeftBtnTapImgChange = .mainLeftButton {
        didSet {
            print(buttonConfig)
            // 이미지 변경
            // right 버튼 숨기기 / 보이기
            self.changeImgWhenViewChanges()
        }
    }
    
    
    
    // MARK: - Label
    private lazy var titleLabel: UILabel = {
        return UILabel().label(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 25)
    }()
    
    
    
    // MARK: - Button
    private lazy var leftButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let btn = UIButton().buttonSustemImage(btnSize: 25, imageString: .menu)
            btn.addTarget(self, action: #selector(self.headerLeftButtonTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var rightButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // fix image
        let btn = UIButton().buttonSustemImage(btnSize: 25, imageString: .fix)
            btn.addTarget(self, action: #selector(self.headerRightButtonTapped), for: .touchUpInside)
            btn.isHidden = true
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
    }
    
    
    
    
    
    
    
    // MARK: - API
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Button Image Config
    /*
     ***** 버튼 이미지 바꿔주는 메서드 (+ hide / show) *****
     
     leftButton이 눌리면   +   화면 전환으로 인해 이미지 교체가 필요하면
     -> buttonfig가 바뀜
        -> didSet
            -> 이 함수를 통해서 이미지가 바뀜 (+ hide / show) <<< - 이 함수가 하는 일
     */
    private func changeImgWhenViewChanges() {
        switch buttonConfig {
        case .menuLeftButton:
            // back Image
            self.leftButton.setImage(.setImg(.back), for: .normal)
            break
            
        case .mainLeftButton:
            // menu Image
            self.leftButton.setImage(.setImg(.menu), for: .normal)
            break
            
            
        case .tableLeftButton:
            // back Image
            self.leftButton.setImage(.setImg(.back), for: .normal)
            
            // right Button 숨기기
            self.rightButton.isHidden = true
            break
            
            
        case .diaryLeftButton:
            // rightButton 보이게 하기
            self.rightButton.isHidden = false
            // fix Image
            self.rightButton.setImage(.setImg(.fix), for: .normal)
            break
        }
    }
}





// MARK: - Selectors

extension HeaderView {
    
    // MARK: - Left Button Config
    /*
     header의 Left버튼을 누르면
        -> 화면 이동                    <<<- 이 함수가 하는 일
        -> 변수 headerButton이 바뀜      <<<- 이 함수가 하는 일
            -> didSet을 통해 이미지가 바뀜
     */
    @objc private func headerLeftButtonTapped() {
        // headerView의 상태에 따라 다르게 반응
        switch buttonConfig {
        case .menuLeftButton:
            // blackViewTapped()를 통해 MainVC로 돌아가므로 따로 코드 X
                // 또한 blackViewTapped()에서 .mainButton으로 바뀜
            break
            
            
        // Main에서 left Button을 누르며,
            // MainVC -> MenuVC
        case .mainLeftButton:
            // 메뉴 오픈 - Delegate
            self.mainHeaderDelegate?.handleGoToMenuVC()
            // left 버튼 용도 바꾸기
            self.buttonConfig = .menuLeftButton
            break
            
            
        // 현재 보여지는 뷰 : TableView
            // TableView -> MainVC
        case .tableLeftButton:
            // MainVC 로 dismiss(테이블뷰 내리기) - Delegate
            self.mainHeaderDelegate?.handleDismiss()
            // left 버튼 용도 바꾸기
            self.buttonConfig = .mainLeftButton
            break
            
            
        // 현재 보여지는 뷰 : Diary
            // DiaryVC -> TableView
        case .diaryLeftButton:
            // DiaryVC 사라지기
            self.mainHeaderDelegate?.handleBackToTableView()
            // left 버튼 용도 바꾸기
            self.buttonConfig = .tableLeftButton
            break
        }
    }
    
    
    
    // MARK: - Right Button Config
    /*
     rightButton ( fix / save )가 눌리면
     -> Delegate를 통해 DiaryVC로
        - rightButton의 이미지를 바꾸고        <<<- 이 함수가 하는 일
        - delegate 실행                     <<<- 이 함수가 하는 일
            -> 상황에 맞게 뷰 변경
     */
    @objc private func headerRightButtonTapped() {
        // 수정모드 진입
        if fixToggle == true {
            self.rightButton.setImage(.setImg(.check), for: .normal)
            
            // 오른쪽 버튼 이미지 변경
            self.diaryHeaderDelegate?.buttonImageChange(fix: true)
            
            
            fixToggle = false
            
        // 저장모드 진입 ( 수정완료 )
        } else {
            self.rightButton.setImage(.setImg(.fix), for: .normal)
            // 오른쪽 버튼 이미지 변경
            self.diaryHeaderDelegate?.buttonImageChange(fix: false)
            
            self.fixToggle = true
        }

    }
}
