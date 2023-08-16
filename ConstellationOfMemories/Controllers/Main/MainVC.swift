//
//  MainVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import UIKit

// 나중에 햄버거 메뉴 만들기
    // ContainerVC
final class MainVC: UIViewController {
    
    // MARK: - Properties
    // header View 싱글톤
    private let headerView: HeaderView = HeaderView.shared
    // CoreData 싱글톤
    private let coreData: CoreDataManager = CoreDataManager.shared
    // coreData를 담을 배열 생성
    private var diaryData: [DiaryData] = []
    
    
    // MARK: - Fix
    // 12시가 지나면 false로 자동으로 바꿔지도록.
    // 방법이...
        // 서버에서?
    private var todayDiaryToggle: Bool = false
    
    
    
    
    // 테이블뷰 토글
    private var tableViewToggle: TableViewEnum = .diary
    
    private var additionalFixToggle: AdditionalMode = .saveMode
    
    private var fontColor: FontColor = .red
    private var currentSetup: CurrentSetup?
    
    private var timeArray: [String] = ["아침", "낮", "저녁", "새벽"]
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Views
    
    
    
    // MARK: - Menu
    private lazy var menuVC: MenuVC = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: 82,
                           height: self.view.frame.height - 610)
        let view = MenuVC(frame: frame)
            view.mainMenuDelegate = self
            
        return view
    }()
    
    
    // MARK: - DiaryTable
    // 테이블 뷰 ( 리스트 뷰 )
    private lazy var diaryTableView: UITableView = {
        let frame = CGRect(x: 0,
                           y: self.view.frame.height - 300,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 150)
        let view = UITableView(frame: frame)
            view.delegate = self
            view.dataSource = self
        
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.alpha = 0
        
            view.register(DiaryTableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.diaryTableViewCell)
        return view
    }()
    
    
    // MARK: - DiaryVC
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    private lazy var diaryVC: DiaryVC = {
        let frame = CGRect(x: self.view.frame.width - 150,
                            y: 150,
                            width: self.view.frame.width,
                            height: self.view.frame.height - 150)
        let view = DiaryVC(frame: frame)
            view.mainDiaryDelegate = self
            view.alpha = 0
        return view
    }()
    
    
    // MARK: - BlackView
    // Menu가 열렸을 때 다른 영역을 터치하면 Menu가 닫히도록하기 위해 blackView 설정
    private lazy var menuBlackView : UIView = {
        let frame = CGRect(x: -self.view.frame.width,
                            y: 0,
                            width: self.view.frame.width,
                            height: self.view.frame.height)
        let view = UIView(frame: frame)
            view.backgroundColor = .clear
        
        // blackView - add gesture
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.blackViewTapped))
            view.addGestureRecognizer(tap)
        return view
    }()
    
    
    // MARK: - Achievement
        // 상점 뷰 및 achivementVC
    private lazy var achievementView: collectionSegementView = {
        let frame = CGRect(x: 0,
                            y: self.view.frame.height - 300,
                            width: self.view.frame.width,
                            height: self.view.frame.height - 150)
        let view = collectionSegementView(frame: frame)
            view.segementMainDelegate = self
            view.alpha = 0
        return view
    }()
    
    
    // MARK: - SetupTable
    // UIView
    // seteup_VC
    private lazy var setupTableView: UITableView = {
        let setupTableFrame = CGRect(x: 0,
                                     y: self.view.frame.height - 300,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - 150)
        let headerFrame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.width,
                           height: 80)
        let view = UITableView(frame: setupTableFrame)
            view.delegate = self
            view.dataSource = self
        
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.alpha = 0
        
            view.register(SetupTableviewCell.self,
                          forCellReuseIdentifier: ReuseIdentifier.setupTableViewCell)
            // setupTableview - headerView 추가
            view.tableHeaderView = UserInfoTableHeader(frame: headerFrame)
            view.isScrollEnabled = false
        return view
    }()
    
    private lazy var additionTableView: UITableView = {
        let frame = CGRect(x: self.view.frame.width,
                           y: 500,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 500)
        let view = UITableView(frame: frame)
        
            view.delegate = self
            view.dataSource = self
        
            view.isScrollEnabled = false
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.alpha = 0
        
            view.register(AdditionCell.self,
                          forCellReuseIdentifier: ReuseIdentifier.additionCell)
        
        return view
    }()
    
    
    
    
    
    
    
    
    // MARK: - FontChange _ Header
    private lazy var fontChangeHeader: FontChangeTableHeader = {
        let headerFrame = CGRect(x: self.view.frame.width,
                           y: 150,
                           width: self.view.frame.width,
                           height: 350)
        return FontChangeTableHeader(frame: headerFrame)
    }()
    
    // MARK: - FontChangeTable
    // setupTable -> [글자 색상 변경] 클릭 -> addtionalTable
    private lazy var fontChangeTableView: UITableView = {
        let additinalTableFrame = CGRect(x: self.view.frame.width,
                                         y: 500,
                                         width: self.view.frame.width,
                                         height: self.view.frame.height - 500)
        let view = UITableView(frame: additinalTableFrame)
            view.delegate = self
            view.dataSource = self
        
//            view.isScrollEnabled = false
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.alpha = 0
        
            view.register(FontChangeCell.self,
                          forCellReuseIdentifier: ReuseIdentifier.fontChangeCell)
        return view
    }()
    
    
    // MARK: - ImageView
    private lazy var backgroundImage: UIImageView = {
        return UIImageView(image: UIImage(named: "blueSky"))
    }()
    
    
    // MARK: - Button
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 37, imageString: .moon)
            btn.addTarget(self, action: #selector(self.starButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure UI
        self.configureMainVC()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Configure UI
    private func configureMainVC() {
        // background_Image
        self.view.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(top: self.view.topAnchor,
                                    bottom: self.view.bottomAnchor,
                                    leading: self.view.leadingAnchor,
                                    trailing: self.view.trailingAnchor)
        
        // 헤더뷰
        self.view.addSubview(self.headerView)
        self.headerView.mainHeaderDelegate = self
        self.headerView.diaryHeaderDelegate = diaryVC
        self.headerView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.view.frame.width,
                                       height: 150)
        
        // footerButton
        self.view.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                 centerX: self.view)
        
        // MARK: - CoreData
        // 코어데이터에서 데이터 가져오기
        self.diaryData = coreData.readDiaryDatas()
    }
}




















// MARK: - Hide_OR_Show

extension MainVC {
    
    // MARK: - Diary _ Table
    private func diaryTableHideOrShow(show: Bool) {
        // diary테이블뷰 보이게 하기
        if show == true {
            // diaryTable_View
            self.view.addSubview(self.diaryTableView)
            
            UIView.animate(withDuration: 0.5) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                // diary테이블뷰 보이게 하기
                self.diaryTableView.alpha = 1
                self.diaryTableView.frame.origin.y = 150
                self.diaryTableView.reloadData()
            }
            
            
        // diary테이블뷰 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // diary테이블뷰 숨기기
                self.diaryTableView.alpha = 0
                self.diaryTableView.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // remove View
                self.diaryTableView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Setup _ Table
    private func setupTableHideOrShow(show: Bool) {
        // setup테이블 보이게 하기
        if show == true {
            print(#function)
            // setupTableView
            self.view.addSubview(self.setupTableView)
            
            UIView.animate(withDuration: 0.5) {
                // 메뉴뷰 숨기기
                self.menuHideOrShow(show: false)
                // setupTable 보이게 하기
                self.setupTableView.alpha = 1
                self.setupTableView.frame.origin.y = 150
                // footerButton 숨기기
                self.footerButton.alpha = 0
            }
            
            
        // setup테이블 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                // setupTable 숨기기
                self.setupTableView.alpha = 0
                self.setupTableView.frame.origin.y = self.view.frame.height
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                
            } completion: { _ in
                // remove View
                self.setupTableView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Addition _ Table
    private func additionTableHideOrShow(show: Bool) {
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    // MARK: - Fix
    // 원래 addition으로 가는 메서드를 바꾸기
    // 새로 만들기 (right _ let _ 전부 다 )
    // fontChanggTable도 다 바꿔야 함 -> tableView reload가 필요 없어짐
    
    
    // MARK: - FontChange _ Table
    private func fontChangeTableHideOrShow(show: Bool) {
        if show == true {
            self.view.addSubview(self.fontChangeTableView)
            self.view.addSubview(self.fontChangeHeader)
            
            UIView.animate(withDuration: 0.5) {
                // setupTable 숨기기
                self.setupTableView.alpha = 0
                self.setupTableView.frame.origin.x = -self.view.frame.width
                
                // additaional 테이블 보이게 하기
                self.fontChangeTableView.alpha = 1
                self.fontChangeTableView.frame.origin.x = 0
                
                // additional Header 보이게 하기
                self.fontChangeHeader.alpha = 1
                self.fontChangeHeader.frame.origin.x = 0
            }
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // setupTable 보이게 하기
                self.setupTableView.alpha = 1
                self.setupTableView.frame.origin.x = 0
                
                // additaional 숨기기
                self.fontChangeTableView.alpha = 0
                self.fontChangeTableView.frame.origin.x = self.view.frame.width
                
                // additional Header 보이게 하기
                self.fontChangeHeader.alpha = 0
                self.fontChangeHeader.frame.origin.x = self.view.frame.width
                
            } completion: { _ in
                self.fontChangeTableView.removeFromSuperview()
                self.fontChangeHeader.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - FontChange _ SelectMode
    private func additionSelectHideOrShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                self.fontChangeTableView.alpha = 0
                
            } completion: { _ in
                self.fontChangeTableView.reloadData()
                
                UIView.animate(withDuration: 0.3) {
                    self.fontChangeTableView.alpha = 1
                }
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                self.fontChangeTableView.alpha = 0
                
            } completion: { _ in
                self.fontChangeTableView.reloadData()
                
                UIView.animate(withDuration: 0.5) {
                    self.fontChangeTableView.alpha = 1
                }
            }
        }
    }
    
    
//    private func background
    
    
    
    
    
    
    
    // private func
    
    
    
    
    // MARK: - Shop _ Collection
    private func shopViewHideOrShow(show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            // achievement_View
            self.view.addSubview(self.achievementView)
            
            UIView.animate(withDuration: 0.5) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                // achievementView 보이게 하기
                self.achievementView.alpha = 1
                self.achievementView.frame.origin.y = 150
                // menuView 숨기기
                self.menuHideOrShow(show: false)
            }
            

        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // achievementView 숨기기
                self.achievementView.alpha = 0
                self.achievementView.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // 뷰에서 나가면 세그먼트를 0으로 되돌려 놓기
                self.achievementView.segmentedControl.selectedSegmentIndex = 0
                self.achievementView.shopSegementHideOrShow(show: true)
                // item이 항상 맨위로 가도록 설정
                self.achievementView.upCollectionView()
                // remove View
                self.achievementView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Achievement _ Collection
    private func achievementViewHideOrShow(show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            // achievement_View
            self.view.addSubview(self.achievementView)
            
            UIView.animate(withDuration: 0.5) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                // achievementView 보이게 하기
                self.achievementView.alpha = 1
                self.achievementView.frame.origin.y = 150
                // menuView 숨기기
                self.menuHideOrShow(show: false)
            }
            
            
        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // achievementView 숨기기
                self.achievementView.alpha = 0
                self.achievementView.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // 뷰에서 나가면 세그먼트를 0으로 되돌려 놓기
                self.achievementView.segmentedControl.selectedSegmentIndex = 0
                self.achievementView.achieveSegementHideOrShow(show: true)
                // item이 항상 맨위로 가도록 설정
                self.achievementView.upCollectionView()
                // remove View
                self.achievementView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - DiaryVC _ View
    private func DiaryViewHideOrShow(show: Bool) {
        
        
        
        // DiaryVC 보이게 하기
        if show == true {
            // diaryVC
            self.view.addSubview(self.diaryVC)
            
            UIView.animate(withDuration: 0.5) {
                // diarytableView 숨기기
                self.diaryTableView.alpha = 0
                self.diaryTableView.frame.origin.x = -self.view.frame.width
                // diaryVC 보이게 하기
                self.diaryVC.alpha = 1
                self.diaryVC.frame.origin.x = 0
            }
            
            
        // DiaryVC 숨기기
        } else {
            self.diaryTableView.reloadData()
            
            UIView.animate(withDuration: 0.5) {
                // diarytableView 보이게 하기
                self.diaryTableView.alpha = 1
                self.diaryTableView.frame.origin.x = 0
                // diaryVC 숨기기
                self.diaryVC.alpha = 0
                self.diaryVC.frame.origin.x = self.view.frame.width
                
            } completion: { _ in
                // remove View
                self.diaryVC.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - MenuVC _ View
    private func menuHideOrShow(show: Bool) {
        // 메뉴 보이게 하기
        if show == true {
            // menuBlack_View
            self.view.addSubview(self.menuBlackView)
            // MenuVC를 blackView에 삽입
                // blackView를 터치하여 사라지면(gesture) menu도 같이 사라짐
            self.menuBlackView.addSubview(self.menuVC)
            
            UIView.animate(withDuration: 0.5) {
                // menuBlackView 보이게 하기
                self.menuBlackView.frame.origin.x = 0
            }
            
        // 메뉴 숨기기
        } else {
            UIView.animate(withDuration: 0.3) {
                // menuBlackView 숨기기
                self.menuBlackView.frame.origin.x = -self.view.frame.width
                
            } completion: { _ in
                // remove View
                self.menuBlackView.removeFromSuperview()
            }
        }
    }
}




















// MARK: - View Transition
// 뷰가 바뀌는 상황 (버튼을 누르는 상황 등)
    // 뷰 전환
    // 왼쪽 버튼의 역할 및 이미지를 바꿈
    // 상황에 따라 필요한 토글 설정
extension MainVC: MainHeaderDelegate {
    // MARK: - MainHeaderDelegate
        // Header의 Left_Button을 누르면 호출 됨
    // MainVC -> MenuVC
    func handleMainToMenu() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .menuViewButton
        // menu_View_보이게 하기
        self.menuHideOrShow(show: true)
    }
    
    // tableView -> MainVC
    func handleTableToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // diary_Table_View_숨기기
        self.diaryTableHideOrShow(show: false)
    }
    
    // DiaryVC -> TableView
    func handleDiaryToTable() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .diaryTableViewButton
        // 일기를 작성 후 Diary_Table로 왔을 때 업데이트를 위한 코드
        self.diaryData = self.coreData.readDiaryDatas()
        // diary_View_숨기기
            // didSelect_Row_At()에서 열림
        self.DiaryViewHideOrShow(show: false)
    }
    
    // AchieveView -> MainVC
    func handleAchievementToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // achievement_View_숨기기
        self.achievementViewHideOrShow(show: false)
    }
    
    // ShopVC -> MainVC
    func handleShopToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // shop_View_숨기기
        self.shopViewHideOrShow(show: false)
    }
    
    // SetupVC -> MainVC
    func handleSetupToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // setup_Table_숨기기
        self.setupTableHideOrShow(show: false)
    }
    
    // Additonal -> Setup
    func handleAdditionalToSetup() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .setupVCButton
        // 테이블뷰의 토글 변경
        self.tableViewToggle = .setup
        // addtionalTableview 숨기기
        self.fontChangeTableHideOrShow(show: false)
    }
    // SelectMode -> Additional_Table
    func handleFixToAdditional() {
        self.additionalFixToggle = .saveMode
        
        self.headerView.buttonConfig = .additionalTableView
        
        self.additionSelectHideOrShow(show: false)
    }
    
    
    
    
    
    // MARK: - Selectors
        // 버튼을 누르는 상황 이외에 화면 변경
    // MenuVC -> MainVC
    @objc private func blackViewTapped() {
        self.headerView.buttonConfig = .mainViewButton
        // menu_View_숨기기
        self.menuHideOrShow(show: false)
    }
    
    // MainVC -> TableView
    @objc private func starButtonTapped() {
        //
        self.headerView.leftButtonAlpha(.back)
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .diaryTableViewButton
        // tableView를 여러군데서 사용하다보니 enum으로 구분.
        self.tableViewToggle = .diary
        // diary_Table_View_보이게 하기
        self.diaryTableHideOrShow(show: true)
    }
    
    
    
    
    
    // MARK: - Table -> ViewTransition
        // 원래는 tableView-didSelectRowAt에 있지만 (.diary)
            // 일관성 + 너무 길어지는 것을 막기 위한 함수 설정
    // Diary_Table -> DiaryVC
    private func tableToDiary() {
        self.diaryTableView.reloadData()
        // 버튼의 이미지 + 역할을 바꿈 (위에서 바꾼 Toggle을 통해 right버튼도 바뀜)
        self.headerView.buttonConfig = .diaryViewButton
        // diary_View_보이게 하기
            // handleBackToTableView() 에서 닫힘
        self.DiaryViewHideOrShow(show: true)
    }
    
    // Setup -> Additional
    private func setupToAddition() {
        // 테이블뷰 토글 바꾸기
        self.tableViewToggle = .fontChangeTable
        // 헤더의 버튼 이미지 + 설정 바꾸기
        self.headerView.buttonConfig = .additionalTableView
        // additional_Table_View 보이게 하기
        self.fontChangeTableHideOrShow(show: true)
    }
    
    // additional -> SelectMode
    private func additionalToFix() {
        // 어떤 셀을 클릭했는 지 넣어둠 ( 업데이트를 하기 위해 )
        guard let currentSetup = self.currentSetup else { return }
        print(currentSetup)
        
        // 테이블뷰 바꾸기 (공통사항) - 토글 바꾸기
        self.additionalFixToggle = .SelectMode
        // header 버튼의 config바꾸기 (RightButton 추가)
        self.headerView.buttonConfig = .AdditionalSelectMode
        // 뷰 전환
            // 테이블뷰 리로드
        self.additionSelectHideOrShow(show: true)
    }
}



// MARK: - MainMenuDelegate
// 메뉴에서 버튼을 눌렀을 때 호출 됨
extension MainVC: MainMenuDelegate {
    // menu -> achieveView
    func handleAchievement() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .achievementVCButton
        // collectionView의 토글을 바꿈
        self.achievementView.collectionViewToggle = .myStar
        // achievement_View_보이게 하기
        self.achievementViewHideOrShow(show: true)
    }
    
    // menu -> ShopView
    func handleShop() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .shopVCButton
        // collectionView의 토글을 바꿈
        self.achievementView.collectionViewToggle = .shop
        // shop_View_보이게 하기
        self.shopViewHideOrShow(show: true)
    }
    
    // menu -> SetupView
    func handleSetup() {
        // tableview 토글 설정
        self.tableViewToggle = .setup
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .setupVCButton
        // setup_Table_보이게 하기
        self.setupTableHideOrShow(show: true)
    }
}




















// MARK: - AchieveMainDelegate
// segement_Control
extension MainVC: SegementMainDelegate {
    func imageTapped() {
        print(#function)
    }
    
    func shop2Tapped() {
        print(#function)
    }
}



// MARK: - MainDiaryDelegate
extension MainVC: MainDiaryDelegate {
    func todayDiaryCompleted() {
        self.todayDiaryToggle = true
    }
}




















// MARK: - TableView

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Section
    // 섹션의 _개수
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableViewToggle {
        case .diary: return 1
        case .setup: return 3
        case .addition: return 1
        case .fontChangeTable: return 1
        }
    }
    
    // 섹션 _타이틀 이름
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableViewToggle {
            
        case .diary: return nil
            
        case .setup:
            if section == 0 { return "일기 작성 시간 설정" }
            else if section == 1 { return "배경화면 설정" }
            else { return "글자 색상 설정" }
            
            
            
        case .addition: return nil
            
            
        case .fontChangeTable: return nil
        }
    }
    
    // 섹션 헤더 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            // background Color
            headerView.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
            // section 헤더의 글자색 바꾸기
            headerView.textLabel?.textColor = .nightFontColor
        }
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Cell
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableViewToggle {
        case .diary: return 140
        case .setup: return 60
        case .addition: return 200
        case .fontChangeTable: return 60
        }
    }
    
    
    
    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewToggle {
        case .diary:
            return self.todayDiaryToggle == false
                ? self.diaryData.count + 1
                : self.diaryData.count
            
            
        case .setup:
            if section == 0 { return 1 }
            else if section == 1 { return 1 }
            else { return 1 }
            
            
        case .addition: return 4
            
        case .fontChangeTable:
            return self.additionalFixToggle == .saveMode
                ? 4
                : 7
        }
    }
    
    
    
    // MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableViewToggle {
        case .diary:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.diaryTableViewCell, for: indexPath) as! DiaryTableViewCell
            
            // 셀의 StringLabel에 Text표시
            if indexPath.row == 0 { cell.diaryDate = "오늘" }
            else if indexPath.row == 1 { cell.diaryDate = "어제" }
            else if indexPath.row == 2 { cell.diaryDate = "그저께" }
            else {
                // 일기를 적은 날을 표시 (X월 X일)
                cell.diaryDate = self.diaryData[indexPath.row - 3].dateString
            }
            return cell
            
            
            
            
            
        case .setup:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.setupTableViewCell, for: indexPath) as! SetupTableviewCell
            
            if indexPath.section == 0 { cell.titleLabel.text = "일기 작성 시간" }
            else if indexPath.section == 1 { cell.titleLabel.text = "아침 배경화면 설정" }
            else { cell.titleLabel.text = "글자 색상 변경" }
            return cell
            
            
            
            
        case .addition:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.additionCell, for: indexPath) as! AdditionCell
            
            
            
            
            
            
            return cell
            
            
            
            
        case .fontChangeTable:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.fontChangeCell, for: indexPath) as! FontChangeCell
            
            // 셀의 이름 정하기
            // saveMode
            if self.additionalFixToggle == .saveMode {
                cell.additionalLabel.text = self.timeArray[indexPath.row]
            
            
            // selectMode
            } else {
                    cell.additionalLabel.text = fontColor.returnString(rawValue: indexPath.row)
            }
            return cell
        }
    }
    
    
    
    
    
    // MARK: - didSelectRowAt
    // 오늘의 일기를 적지 않았다면 -> DiaryVC('오늘' 셀)를 FixMode로 진입
    // 적었다면, -> SaveMode로 진입
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.tableViewToggle {
        case .diary:
            // 첫번째 셀
            if indexPath.row == 0 {
                // 오늘 일기를 적지 않았다면,
                if self.todayDiaryToggle == false {
                    // 오늘 일기를 적지 않았다면 빈칸으로 교체
                    self.diaryVC.diaryTextView.text = ""
                    // 데이터 create를 위해 nil 넣기
                    self.diaryVC.diaryData = nil
                    // fix모드로 diaryVC진입
                    self.headerView.rightButtonConfig = .fixMode
                    
                    
                // 오늘 일기를 적었다면
                } else {
                    // save모드로 diaryVC진입
                    self.headerView.rightButtonConfig = .saveMode
                    self.diaryVC.diaryData = self.diaryData[indexPath.row]
                    
                    
                }
                
                
            // 2번째 셀부터 ~~~ 마지막 셀까지
            } else if indexPath.row > 0 {
                // save모드로 diaryVC진입
                self.headerView.rightButtonConfig = .saveMode
                // todayDiarytoggle에 따라서 셀 표시가 달라짐
                self.diaryVC.diaryData = self.todayDiaryToggle == false
                    ? self.diaryData[indexPath.row - 1]
                    : self.diaryData[indexPath.row]
            }
            
            // 뷰 전환 (일관성을 위해 함수로 만들어 둠)
            // dairy_Table -> DiaryVC
            self.tableToDiary()
            break
            
            
            
            
            
        case .setup:
            // enum변경
            if indexPath.section == 0 {
                print("0")
                
                
                
            } else if indexPath.section == 1 {
               print("1")
                
                
                
            } else {
                // setupTable -> AdditionalTable
                self.setupToAddition()
            }
            break
            
            
            
            
            
            
            
            
            
        case .addition:
            
            
            
            
            break
            
            
            
        case .fontChangeTable:
            // saveMode일 때
            if self.additionalFixToggle == .saveMode{
                // 아침
                if indexPath.row == 0 { self.currentSetup = .morning
                // 낮
                } else if indexPath.row == 1 { self.currentSetup = .daytime
                // 저녁
                } else if indexPath.row == 2 { self.currentSetup = .night
                // 새벽
                } else { self.currentSetup = .dawn }
                
                
                // additional -> FixMode
                self.additionalToFix()
                
                
                
            // SelectMode일 때
            } else {
                // 셀을 누르면 헤더의 색(레이블 버튼)이 변경
                guard let currentSetup = currentSetup else { return }
                // FontColor.selectedInt에 저장
                switch currentSetup {
                case .morning:
                    
                    
                    break
                    
                    
                case .daytime:
                    
                    
                    break
                    
                    
                case .night:
                    break
                    
                    
                case .dawn:
                    break
                }
                
                // 맨 위로???? (Animate 사용)
                
                print(indexPath.row)
            }
            break
        }
    }
}
