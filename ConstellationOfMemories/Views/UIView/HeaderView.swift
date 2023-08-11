//
//  HeaderView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Properties
    // 싱글톤
    static let shared = HeaderView()
    
    // MainVC
    var mainHeaderDelegate: MainHeaderDelegate?
    // DiaryVC
    var diaryHeaderDelegate: DiaryHeaderDelegate?
    
    
    /*
     // 이 함수가 하는 일
        - 뷰가 바뀌는 경우에 buttonConfig가 바뀜
        - 버튼의 이미지 + hide / show 여부를 결정
     
     // ******************************************************
     
     // 이 변수를 호출하는 함수
        - headerLeftButtonTapped() - HeaderView
        - didSelectRowAt           - MainVC
        - blackViewTapped()        - MainVC
        - starButtonTapped()       - MainVC
     */
    
    
    
    var buttonConfig: LeftBtnTapImgChange = .mainViewButton {
        didSet {
            print(buttonConfig)
            self.changeImgWhenViewChanges()
        }
    }
    
    
    /*
     // 이 함수가 하는 일
        - rightButtonConfig이 바뀌면 didSet을 통해 headerRightButton(_:)호출
            - rightButton의 이미지를 바꿈
            - rightButtonConfig에 따라 delegate 호출
     
     // ******************************************************

     // 이 변수를 호출하는 함수
        - headerRightButtonTapped()
        - headerLeftButtonTapped()
     
     
        // - DiaryViewHideOrShow         - MainVC
     */
    var rightButtonConfig: RightBtnTapImgChange = .saveMode {
        didSet {
            self.headerRightButton(rightButtonConfig)
        }
    }
    
    
    
    // MARK: - Label
    private lazy var titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 25)
    }()
    
    
    
    // MARK: - Button
    private lazy var leftButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // menu image
        let btn = UIButton().buttonSustemImage(btnSize: 31, imageString: .menu)
            btn.addTarget(self, action: #selector(self.headerLeftButtonTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var rightButton: UIButton = {
        // 나중에 다크모드 / 화이트모드에 따라 바뀌도록 이미지 바꾸기 (시스템????)
        // fix image
        let btn = UIButton().buttonSustemImage(btnSize: 31, imageString: .fix)
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
    
    
    

}




// MARK: - Selectors

extension HeaderView {
    
    // MARK: - Left Button Config
    /*
     // 함수 작동 원리
        header의 Left버튼을 누르면
            -> 화면 이동(delegate)          <<<- 이 함수가 하는 일
            -> rightButtondml 역할 바꾸기    <<<- 이 함수가 하는 일
     */
    @objc private func headerLeftButtonTapped() {
        switch buttonConfig {
        // menu_LeftButton_Tapped
        case .menuViewButton:
            // blackViewTapped()를 통해 MainVC로 돌아가므로 따로 코드 X
                // 또한 blackViewTapped()에서 .mainButton으로 바뀜
            break
            
            
        // Main_LeftButton_Tapped
            // MainVC -> MenuVC
        case .mainViewButton:
            // 메뉴 오픈 - Delegate
            self.mainHeaderDelegate?.handleGoToMenuVC()
            break
            
            
        // TableView_LeftButton_Tapped
            // TableView -> MainVC
        case .tableViewButton:
            // MainVC 로 dismiss(테이블뷰 내리기) - Delegate
            self.mainHeaderDelegate?.handleDismiss()
            break
            
            
        // Diary_LeftButton_Tapped
            // DiaryVC -> TableView
        case .diaryViewButton:
            // DiaryVC 사라지기
            self.mainHeaderDelegate?.handleBackToTableView()
            // fix모드에서 leftButton클릭 시 자동으로 save모드로 바뀜
            self.rightButtonConfig = .saveMode
            break
            
            
        case .shopVCButton:
            // 뒤로가기
            self.mainHeaderDelegate?.handleBackShopToMainVC()
            break
            
            
        case .setupVCButton:
            // 뒤로가기
            self.mainHeaderDelegate?.handleBackSetupToMain()
            break
            
            
        case .achievementVCButton:
            // 뒤로가기
            self.mainHeaderDelegate?.handleBackAchievementToMain()
            break
        }
    }
    
    // MARK: - Button Image Config
    // ***** 뷰가 바뀌었을 때 버튼 이미지 바꿔주는 메서드 (+ hide / show) *****
    /*
     // 함수 작동 원리
        화면이(View가) 바뀌면
            -> buttonfig가 바뀜 -> didSet (이 함수가 호출 됨)
                -> 이 함수를 통해서 이미지가 바뀜 (+ hide / show) <<< - 이 함수가 하는 일
     
     // ******************************************************
     
     // 코드 설명
        // headerLeftButtonTapped()와 이 함수를 나눠놓은 이유:
            // MainVC -> TableView
            // MenuVC -> MainVC
            // Tableview -> DiaryVC
        // 처럼 버튼을 누르지 않고 뷰가 바뀌어 버러 이미지만 바꿔야 하는 경우가 있기 때문
     */
    private func changeImgWhenViewChanges() {
        switch buttonConfig {
        // MenuVC 화면에서의 버튼 이미지
        case .menuViewButton:
            // back Image
            self.leftButton.setImage(.setImg(.back), for: .normal)
            break
            
            
        // MainVC 화면에서의 버튼 이미지
        case .mainViewButton:
            // menu Image
            self.leftButton.setImage(.setImg(.menu), for: .normal)
            self.rightButton.isHidden = true
            self.titleLabel.text = "추억 일기"
            break
            
            
        // TableView 화면에서의 버튼 이미지 및 설정
        case .tableViewButton:
            // back Image
            self.leftButton.setImage(.setImg(.back), for: .normal)
            // right Button 숨기기
            self.rightButton.isHidden = true
            break
            
            
        // DiaryVC 화면에서의 버튼 설정
        case .diaryViewButton:
            // rightButton 보이게 하기
            self.rightButton.isHidden = false
            self.rightButton.setImage(.setImg(.fix), for: .normal)
            break
            
            
        case .shopVCButton:
            self.rightButton.isHidden = false
            self.rightButton.setImage(.setImg(.coin), for: .normal)
            self.titleLabel.text = "상점"
            break
            
            
        case .setupVCButton:
            
            
            break
            
            
        case .achievementVCButton:
            
            
            break
        }
    }
    
    
    
    
    
    
    // MARK: - Right Button Config
    /*
     // 함수 작동 원리
        rightButton ( fix / save )가 눌리면         <<<- 이 함수가 하는 일
        -> 함수 headerRightButton() 실행            <<<- 이 함수가 하는 일
     
            - rightButton의 이미지를 바꿈
            - delegate 실행
                -> 상황에 맞게 뷰의 레이아웃 등 변경
     */
    @objc private func headerRightButtonTapped() {
        switch rightButtonConfig {
        case .fixMode:
            self.headerRightButton(.fixMode)
            // save모드로 변경
            self.rightButtonConfig = .saveMode
            break
            
            
        case .saveMode:
            self.headerRightButton(.saveMode)
            // fix모드로 변경
            self.rightButtonConfig = .fixMode
            break
            
            
        case .coin:
            break
        }
    }
    
    // MARK: - Right Button Action
    /*
     // 함수 작동 원리
        rightButton ( fix / save )가 눌리면   +   rightButton이 눌리면
        -> 이 함수가 호출 됨
     
            - rightButton의 이미지를 바꾸고        <<<- 이 함수가 하는 일
            - delegate 실행                     <<<- 이 함수가 하는 일
     
                -> 상황에 맞게 뷰 변경 <- DiaryVC_diaryFixMode(_:)
     
     // ******************************************************
     // 코드 설명
        // leftButton과 달리 headerRightButton에서 delegate처리
        // headerRightButtonTapped() 와 이 함수를 나눠 놓은 이유
            // 상황에 따라
                // DiaryVC에서 fixMode로 시작
                // DiaryVC에서 LeftButton을 누르면 .saveMode로 변경 등
            // 버튼을 누르지 않고 함수가 작동해야 하는 경우가 있기 때문에 나눠 놓음
     */
    func headerRightButton(_ rightButtonConfig: RightBtnTapImgChange) {
        switch rightButtonConfig {
        case .fixMode:
            // rightButton 이미지 변경
            self.rightButton.setImage(.setImg(.check), for: .normal)
            
            // 오른쪽 버튼 이미지 변경
            self.diaryHeaderDelegate?.diaryFixMode(true)
            break
            
            
        case .saveMode:
            // rightButton 이미지 변경
            self.rightButton.setImage(.setImg(.fix), for: .normal)
            
            // 오른쪽 버튼 이미지 변경
            self.diaryHeaderDelegate?.diaryFixMode(false)
            break
            
            
        case .coin:
            break
        }
        
        
    }
}
