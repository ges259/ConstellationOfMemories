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
        - starButtonTapped()       - MainVC 등
     */
    var buttonConfig: LeftBtnTapImgChange = .mainViewButton {
        didSet {
//            print(buttonConfig)
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
    var rightButtonConfig: RightBtnTapImgChange = .saveMode
    
    
    
    
    
    
    
    
    
    
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
        btn.alpha = 0
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
            self.mainHeaderDelegate?.handleMainToMenu()
            break
            
            
        // TableView_LeftButton_Tapped
            // TableView -> MainVC
        case .diaryTableViewButton:
            // MainVC 로 dismiss(테이블뷰 내리기) - Delegate
            self.mainHeaderDelegate?.handleTableToMain()
            break
            
            
        // Diary_LeftButton_Tapped
            // DiaryVC -> TableView
        case .diaryViewButton:
            // DiaryVC 사라지기
            self.mainHeaderDelegate?.handleDiaryToTable()
            // 저장뷰인 상태에서 나가면 ( - rightButtonConfig느 fixMode인 상태)
                // -> headerRightbuttonTapped()에서 fixMode로 넘어가는 애니메이션이 나옴
                    // 이를 방지하기 위해 saveMode로 바꾸고 실행
            self.rightButtonConfig = .saveMode
            // check표시를 클릭하지 않고 왼쪽버튼을 통해 나가도 저장이 될 수 있도록 함
            self.headerRightButtonTapped()
            // right 버튼 숨기기
            self.rightButtonHide()
            break
            
            
        case .homeViewButton:
            
            self.mainHeaderDelegate?.handleHomeToMain()
            break
            
            
        case .shopVCButton:
            // 뒤로가기
            self.mainHeaderDelegate?.handleShopToMain()
            break
            
        case .detailViewButton:
            
            self.mainHeaderDelegate?.handleDetailToShop()
            break
            
            
        case .setupVCButton:
            // 뒤로가기
            self.mainHeaderDelegate?.handleSetupToMain()
            break
            
            
        case .achievementVCButton:
            // 뒤로가기
            self.mainHeaderDelegate?.handleAchievementToMain()
            break
            
            
            
            
        case .additionTableView:
            self.mainHeaderDelegate?.handleAdditionToSetup()
            break
        
            
            
            
        case .fontchangeTableView:
            self.rightButtonHide()
            self.mainHeaderDelegate?.handleFontToAddition()
            break
            
            
//        case .AdditionalSelectMode:
//            // left버튼을 연타했을 때 crash가 발생하여 막아 둠
//            self.leftButtonAlpha()
//            // right버튼 숨기기
//            self.rightButtonHide()
//            // 다시 additional로 돌아가기 + rightbutton 숨기기
//            self.mainHeaderDelegate?.handleFixToAdditional()
//            break
        
        
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Right Button Config
    /*
     // 함수 호출 과정
        rightButton ( fixMode / saveMode )가 눌리면 현재 함수가 실행 됨
     
     // 이 함수가 하는 일
            - rightButton의 이미지를 바꾸고           <<<- 이 함수가 하는 일
            - delegate 실행                        <<<- 이 함수가 하는 일
                -> 상황에 맞게 뷰 변경 <- DiaryVC_diaryFixMode(_:)
     
     */
    @objc private func headerRightButtonTapped() {
        switch rightButtonConfig {
        // 현재: fixMode
            // rightButton을 누르면 SaveMode로 진입
        case .fixMode:
            // rightButton 이미지 변경 + 애니메이션
            self.rightButtonShow(.check)
            // fix모드 진입
            self.diaryHeaderDelegate?.diaryFixMode(true)
            // save모드로 변경
                // fix모드에서 rightButton 누르면 save모드로 들어갈 수 있게
            self.rightButtonConfig = .saveMode
            break
            
            
            
        // 현재: saveMode
            // rightButton을 누르면 FixMode로 진입
        case .saveMode:
            // rightButton 이미지 변경 + 애니메이션
            self.rightButtonShow(.fix)
            // save모드 진입
            self.diaryHeaderDelegate?.diaryFixMode(false)
            // fix모드로 변경
                // save모드에서 rightButton 누르면 fix모드로 들어갈 수 있게
            self.rightButtonConfig = .fixMode
            break
            
            
        case .coin:
            self.rightButtonShow(.coin)
            break
            
            
        case .fontChange:
            // rightButton 숨기기
            self.rightButtonHide()
            // check 버튼을 누렀다면 뒤로가기 (additional 로 )
            self.mainHeaderDelegate?.handleFontToAddition()
            // MARK: - Fix
            // 변경사항 저장
            
            break
        case .shopDetail:
            print(#function)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Button Image
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
        // MenuVC 화면들어오면 -> 버튼 이미지
        case .menuViewButton:
            // 이미지 변경 + 애니메이션
            self.leftButtonAlpha(.back)
            break
            
            
        // MainVC 화면들어오면 -> 버튼 이미지
        case .mainViewButton:
            // left버튼 이미지 바꾸기 + 애니메이션
            self.leftButtonAlpha(.menu)
            // titleLabel 변경
            self.titleLabel.text = "추억 일기"
            break
            
            
        // TableView 화면들어오면 -> 버튼 이미지 및 설정
        case .diaryTableViewButton:
            // right Button 숨기기
            self.rightButtonHide()
            
            break
            
            
        // DiaryVC 화면들어오면 -> 버튼 설정
        case .diaryViewButton:
            // MainVC - tableToDiary()를 통해
                // -> rightbuttonConfig를 설정
                // -> 설정값에 따라 headerRightButtonTapped()를 하여 뷰를 바꿈
            self.headerRightButtonTapped()
            break
        
        case .homeViewButton:
//            self.rightButtonShow(.check)
            break
            
            
        // shopVC 화면들어오면 -> 버튼 이미지 및 텍스트 설정
        case .shopVCButton:
            // titleLabel 바꾸기
            self.titleLabel.text = "상점"
            self.rightButtonHide()
            break
            
            
        case .detailViewButton:
            self.rightButtonShow(.check)
            break
            
            
            
        case .setupVCButton:
            break
            
            
        case .achievementVCButton:
            break
            
            
            
        case .additionTableView:
            break
            
            
            
        case .fontchangeTableView:
            self.rightButtonConfig = .fontChange
            self.rightButtonShow(.check)
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Animated
    // left버튼의 이미지가 바뀔 때 자연스럽게 바뀔 수 있도록 하는 메서드
    func leftButtonAlpha(_ imageString: imageString? = .back) {
        
        UIView.animate(withDuration: 0.15) {
            self.leftButton.alpha = 0
            
        } completion: { _ in
            self.leftButton.setImage(.setImg(imageString!), for: .normal)
            
            UIView.animate(withDuration: 0.15) {
                self.leftButton.alpha = 1
            }
        }
    }
    
    
    
    
    
    
    // rightButton
    func rightButtonShow(_ imageString: imageString = .back) {
        self.rightButton.alpha = 0
        self.rightButton.setImage(.setImg(imageString), for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.rightButton.alpha = 1
        }
    }
    
    
    private func rightButtonHide() {
        UIView.animate(withDuration: 0.3) {
            self.rightButton.alpha = 0
        }
    }
}
