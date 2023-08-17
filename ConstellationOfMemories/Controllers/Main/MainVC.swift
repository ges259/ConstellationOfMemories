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
    
    
//    private var fontColor: FontColor = .red
    
//    private var timeArray: [String] = ["아침", "낮", "저녁", "새벽"]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Views
    
    
    
    // MARK: - Menu
    private lazy var menuVC: MenuVC = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: 82,
                           height: self.view.frame.height - 500)
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
    private lazy var collectionSegementView: CollectionSegementView = {
        let frame = CGRect(x: 0,
                            y: self.view.frame.height - 300,
                            width: self.view.frame.width,
                            height: self.view.frame.height - 150)
        let view = CollectionSegementView(frame: frame)
            view.alpha = 0
//        view.firstCollection.firstMainDelegate = self
            view.secondCollection.secondMainDelegate = self
        return view
    }()
    
    
    
    // MARK: - Detail_View
    private lazy var detailView: DetailView = {
        let width: CGFloat = (self.view.frame.width - 150) / 4 * 5
        
        let frame = CGRect(x: (self.view.frame.width - width) / 2,
                           y: 200,
                           width: width,
                           height: width / 9 * 16)
        
        let view = DetailView(frame: frame)
            view.backgroundColor = .blue
            view.alpha = 0
        return view
    }()
    
    
    
    // MARK: - Detail_Black_View
    private lazy var detailBlackView: UIView = {
        let frame = CGRect(x: 0,
                            y: 150,
                            width: self.view.frame.width,
                            height: self.view.frame.height)
        let view = UIView(frame: frame)
            view.backgroundColor = UIColor(white: 1, alpha: 0.2)
            view.alpha = 0
        // blackView - add gesture
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.detailBlackViewTapped))
            view.addGestureRecognizer(tap)
        return view
    }()
    
    
    
    // MARK: - Setup_Table
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
    
    
    
    // MARK: - Home _ View
    private lazy var homeHeader: HomeHeader = {
        let headerFrame = CGRect(x: 0,
                                 y: self.view.frame.height,
                                 width: self.view.frame.width,
                                 height: 225)
        return HomeHeader(frame: headerFrame)
    }()
    
    
    
    // MARK: - CollectionSegement
    private lazy var collectionSegement: CollectionSegementView = {
        let frame = CGRect(x: 0,
                           y: self.view.frame.height + 375,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 375)
        let view = CollectionSegementView(frame: frame)
            view.backgroundColor = .clear
            view.alpha = 0
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
    
    
    
    // MARK: - Home _ Collection
    private func HomeViewHideOrShow(show: Bool) {
        if show == true {
            self.view.addSubview(self.homeHeader)
            self.view.addSubview(self.collectionSegement)

            UIView.animate(withDuration: 0.5) {
                // 메뉴바 숨기기
                self.menuHideOrShow(show: false)

                // fontChangeHeader 테이블 보이게 하기
                self.homeHeader.alpha = 1
                self.homeHeader.frame.origin.y = 150
                
                // collectionSegement 테이블 보이게 하기
                self.collectionSegement.alpha = 1
                self.collectionSegement.frame.origin.y = 383
            }
            

        } else {
            UIView.animate(withDuration: 0.5) {
                // fontChangeHeader 숨기기
                self.homeHeader.alpha = 0
                self.homeHeader.frame.origin.y = self.view.frame.height
                
                // collectionSegement 숨기기
                self.collectionSegement.alpha = 0
                self.collectionSegement.frame.origin.y = self.view.frame.height + 383

            } completion: { _ in
                // 뷰에서 나가면 세그먼트를 0으로 되돌려 놓기
                self.collectionSegement.segmentedControl.selectedSegmentIndex = 0
                self.collectionSegement.shopViewHideOrShow(show: true)
                
                self.homeHeader.removeFromSuperview()
                self.collectionSegement.removeFromSuperview()
            }
        }
    }
    
    
    
    
    // MARK: - Shop _ Collection
    private func shopViewHideOrShow(show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            // achievement_View
            self.view.addSubview(self.collectionSegementView)
            self.view.addSubview(self.detailView)
            self.view.addSubview(self.detailBlackView)
            
            UIView.animate(withDuration: 0.5) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                // achievementView 보이게 하기
                self.collectionSegementView.alpha = 1
                self.collectionSegementView.frame.origin.y = 150
                // menuView 숨기기
                self.menuHideOrShow(show: false)
            }
            

        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // achievementView 숨기기
                self.collectionSegementView.alpha = 0
                self.collectionSegementView.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // 뷰에서 나가면 세그먼트를 0으로 되돌려 놓기
                self.collectionSegementView.segmentedControl.selectedSegmentIndex = 0
                self.collectionSegementView.shopViewHideOrShow(show: true)
                // item이 항상 맨위로 가도록 설정
                self.collectionSegementView.upCollectionView()
                // remove View
                self.collectionSegementView.removeFromSuperview()
                self.detailView.removeFromSuperview()
                self.detailBlackView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Achievement _ Collection
    private func achievementViewHideOrShow(show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            self.view.addSubview(self.collectionSegementView)
            
            UIView.animate(withDuration: 0.5) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                // achievementView 보이게 하기
                self.collectionSegementView.alpha = 1
                self.collectionSegementView.frame.origin.y = 150
                // menuView 숨기기
                self.menuHideOrShow(show: false)
            }
            
            
        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // achievementView 숨기기
                self.collectionSegementView.alpha = 0
                self.collectionSegementView.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // 뷰에서 나가면 세그먼트를 0으로 되돌려 놓기
                self.collectionSegementView.segmentedControl.selectedSegmentIndex = 0
                self.collectionSegementView.shopViewHideOrShow(show: true)
                // item이 항상 맨위로 가도록 설정
                self.collectionSegementView.upCollectionView()
                // remove View
                self.collectionSegementView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Detail_View
    func detailViewHideOrShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                // detailBlackView 보이게 하기
                self.detailBlackView.alpha = 1
                // detailview 보이게 하기
                self.detailView.alpha = 1
            }
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // detailBlackView 보이게 하기
                self.detailBlackView.alpha = 0
                // detailview 보이게 하기
                self.detailView.alpha = 0
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
    
    // DiaryVC -> Diary_Table
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
    
    // Home -> Main
    func handleHomeToMain() {
        self.headerView.buttonConfig = .mainViewButton
        
        self.HomeViewHideOrShow(show: false)
    }
    
    // ShopVC -> MainVC
    func handleShopToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // shop_View_숨기기
        self.shopViewHideOrShow(show: false)
    }
    
    // detailView -> ShopView
    func handleDetailToShop() {
        self.headerView.buttonConfig = .shopVCButton
        self.detailViewHideOrShow(show: false)
    }
    
    // SetupVC -> MainVC
    func handleSetupToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // setup_Table_숨기기
        self.setupTableHideOrShow(show: false)
    }
    
    
    
    // MARK: - Selectors
        // 버튼을 누르는 상황 이외에 화면 변경
    // MenuVC -> MainVC
    @objc private func blackViewTapped() {
        self.headerView.buttonConfig = .mainViewButton
        // menu_View_숨기기
        self.menuHideOrShow(show: false)
    }
    
    // detailView -> shop
    @objc private func detailBlackViewTapped() {
        self.headerView.buttonConfig = .shopVCButton
        self.detailViewHideOrShow(show: false)
    }
    
    // MainVC -> Diary_Table
    @objc private func starButtonTapped() {
        // 버튼의 이미지 바꾸기
            // header에서 바꾸면 diaryVC -> Diary_Table로 이동할 때도 애니메이션이 작동하므로 여기서 설정
        self.headerView.leftButtonAlpha(.back)
        // 버튼의 역할을 바꿈
        self.headerView.buttonConfig = .diaryTableViewButton
        // tableView를 여러군데서 사용하다보니 enum으로 구분.
        self.tableViewToggle = .diary
        // diary_Table_View_보이게 하기
        self.diaryTableHideOrShow(show: true)
    }
    
    
    
    // MARK: - Cell -> View_Transition
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
}



// MARK: - MainMenuDelegate
// 메뉴에서 버튼을 눌렀을 때 호출 됨
extension MainVC: MainMenuDelegate {
    // menu -> achieveView
    func handleAchievement() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .achievementVCButton
        // collectionView의 토글을 바꿈
        
        // MARK: - Fix
        self.collectionSegementView.collectionToggle = .home
        // achievement_View_보이게 하기
        self.achievementViewHideOrShow(show: true)
    }

    // menu -> HomeView
    func handleHome() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .homeViewButton
        // collectionView의 토글을 바꿈
        self.collectionSegementView.collectionToggle = .home
        // Home_View_보이게 하기
        self.HomeViewHideOrShow(show: true)
    }
    
    // menu -> ShopView
    func handleShop() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .shopVCButton
        // collectionView의 토글을 바꿈
        self.collectionSegementView.collectionToggle = .shop
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




// MARK: - SecondMainDelegate
extension MainVC: SecondMainDelegate {
    // shop -> Detail
        // second segement를 누르면 detail로 진입
    func secondTapped() {
        // right 버튼 보이게 하기 + 이미지 바꾸기
        self.headerView.rightButtonConfig = .shopDetail
        // left 버튼의 용도 바꾸기
        self.headerView.buttonConfig = .detailViewButton
        // detail_View + detail_Black_View 보이게 하기
        self.detailViewHideOrShow(show: true)
    }
}


//extension MainVC: FirstMainDelegate {
//    func firstTapped() {
//        print("First")
//    }
//}



















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
        case .setup: return 1
        }
    }
    
    // 섹션 _타이틀 이름
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if self.tableViewToggle == .setup {
            return "알림 설정"
        } else {
            return nil
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
        }
    }
    
    
    
    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewToggle {
        case .diary:
            return self.todayDiaryToggle == false
                ? self.diaryData.count + 1
                : self.diaryData.count
            
        case .setup: return 1
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
                cell.titleLabel.text = "알림"
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
            break
        }
    }
}
