//
//  MainVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import UIKit

final class MainVC: UIViewController {
    
    // MARK: - Properties
    // header View 싱글톤
    private let headerView: HeaderView = HeaderView.shared
    // CoreData 싱글톤
    private let coreData: CoreDataManager = CoreDataManager.shared
    
    
    
    // coreData를 담을 배열 생성
    private var diaryData: [DiaryData] = [] {
        didSet {
            self.diaryTable.diaryData = self.diaryData
        }
    }
    
    
    var blackViewToggle: BlackViewToggle = .menu
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Views
    
    
    
    // MARK: - Menu
    private lazy var menuVC: MenuVC = {
        let frame = CGRect(x: -82,
                           y: 150,
                           width: 82,
                           height: self.view.frame.height - 500)
        let view = MenuVC(frame: frame)
            view.mainMenuDelegate = self
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
            view.firstCollection.firstMainDelegate = self
            view.secondCollection.secondMainDelegate = self
        return view
    }()
    
    
    
    // MARK: - Home_View
    private lazy var homeHeader: HomeHeader = {
        let headerFrame = CGRect(x: 0,
                                 y: self.view.frame.height,
                                 width: self.view.frame.width,
                                 height: 225)
        return HomeHeader(frame: headerFrame)
    }()
    private lazy var collectionSegement: CollectionSegementView = {
        let frame = CGRect(x: 0,
                           y: self.view.frame.height + 383,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 375)
        let view = CollectionSegementView(frame: frame)
            view.firstCollection.firstHomeHeaderDelegate = self.homeHeader
            view.secondCollection.headerSegementDelegate = self.homeHeader
        return view
    }()
    
    
    
    // MARK: - ShopCollection_View
    private lazy var shopCollection: ShopCollectionView = {
        let frame = CGRect(x: 0,
                           y: self.view.frame.height - 300,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 150)
        let view = ShopCollectionView(frame: frame)
            view.mainShopDelgate = self
        return view
    }()
    
    
    
    // MARK: - Setup_Table
    private lazy var setupTableView: SetupTableView = {
        let frame = CGRect(x: 0,
                           y: self.view.frame.height - 300,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 150)
        return SetupTableView(frame: frame)
    }()
    
    
    
    // MARK: - Diary_Table
    private lazy var diaryTable: DiaryTableView = {
        let frame = CGRect(x: 0,
                           y: self.view.frame.height - 300,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 150)
        let view = DiaryTableView(frame: frame)
            view.mainDiaryTableDelegate = self
            view.diaryVCTableDelegate = diaryVC
        return view
    }()
    
    
    
    
    // MARK: - DiaryVC
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    private lazy var diaryVC: DiaryVC = {
        let frame = CGRect(x: self.view.frame.width - 150,
                            y: 150,
                            width: self.view.frame.width,
                            height: self.view.frame.height - 150)
        return DiaryVC(frame: frame)
    }()
    
    
    
    // MARK: - Detail_View
    private lazy var detailView: DetailView = {
        let width: CGFloat = (self.view.frame.width - 150) / 4 * 5
        let frame = CGRect(x: (self.view.frame.width - width) / 2,
                           y: 200,
                           width: width,
                           height: width / 9 * 16)
        return DetailView(frame: frame)
    }()
    
    
    
    // MARK: - Black_View
    private lazy var blackView: UIView = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.view.frame.width,
                           height: self.view.frame.height)
        let view = UIView(frame: frame)
            view.backgroundColor = .clear
            view.alpha = 0
        // blackView - add gesture
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.detailBlackViewTapped))
            view.addGestureRecognizer(tap)
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
        
        // get_CoreData
        // check_today_diary
        self.checkTodayDiary()
    }
    // MARK: - Configure UI
    private func configureMainVC() {
        // background_Image
        self.view.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(top: self.view.topAnchor,
                                    bottom: self.view.bottomAnchor,
                                    leading: self.view.leadingAnchor,
                                    trailing: self.view.trailingAnchor)
        
        // header_View
        self.view.addSubview(self.headerView)
        self.headerView.mainHeaderDelegate = self
        self.headerView.diaryHeaderDelegate = diaryVC
        self.headerView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.view.frame.width,
                                       height: 150)
        
        // footer_Button
        self.view.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                 centerX: self.view)
    }
    
    
    
    // MARK: - CoreData
    private func checkTodayDiary() {
        // 코어데이터에서 데이터 가져오기
        self.diaryData = self.coreData.readDiaryDatas()
        
        // 오늘 일기를 작성 했는지 확인
        if diaryData.isEmpty == false {
            self.coreData.configureTodayDiaryToggle(diaryData: self.diaryData[0])
        }
    }
}




















































// MARK: - Hide_OR_Show

extension MainVC {
    
    // MARK: - MenuVC _ View
    private func menuHideOrShow(show: Bool, itemTapped: Bool, footerHide: Bool) {
        // 메뉴 보이게 하기
        if show == true {
            self.view.addSubview(self.blackView)
            self.view.addSubview(self.menuVC)
            
            UIView.animate(withDuration: 0.5) {
                // menuBlackView 보이게 하기
                self.blackView.alpha = 1
                self.menuVC.frame.origin.x = 0
            }
            
            
        // 메뉴 숨기기
        } else {
            // 메뉴 -> 메뉴 안의 아이템을 클릭하지 않고 main화면으로 다시 돌아간다면
                // detail_Black_View 삭제
            // true: (backButton / Black_View_Tapped)
            // false: (achieve/home/shop/setup)으로 들어가면
            
            if itemTapped == false { self.blackView.removeFromSuperview() }
            
            UIView.animate(withDuration: 0.5) {
                // menuBlackView 숨기기
                self.blackView.alpha = 0
                self.menuVC.frame.origin.x = -82
                
                if footerHide == true {
                    // footer 버튼 숨기기
                    self.footerButton.alpha = 0
                }
                
            } completion: { _ in
                self.menuVC.removeFromSuperview()
                // 메뉴의 item을 클릭하여 다음 뷰로 넘어가지 않았다면
                    // detail_Black_View 를 삭제
                // 이렇게 한 이유는: 다음 화면(ahieve/shop)에서 detail_Black_View를 사용.
                    // 하지만 여기서 뷰를 삭제해버린다면 다음 화면에서 안 뜸.
                
            }
        }
    }
    
    
    
    // MARK: - Achievement _ Collection
    private func achievementViewHideOrShow(show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            self.view.addSubview(self.collectionSegementView)
            self.view.addSubview(self.detailView)
            self.view.bringSubviewToFront(self.blackView)
            
            UIView.animate(withDuration: 0.6) {
                // menuView 숨기기
                self.menuHideOrShow(show: false, itemTapped: true, footerHide: true)
                // achievementView 보이게 하기
                self.collectionSegementView.alpha = 1
                self.collectionSegementView.frame.origin.y = 150
            }
            
            
        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: 0.6) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // achievementView 숨기기
                self.collectionSegementView.alpha = 0
                self.collectionSegementView.frame.origin.y = self.view.frame.height - 383
                
            } completion: { _ in
                // remove View
                self.blackView.removeFromSuperview()
                self.collectionSegementView.removeFromSuperview()
                self.detailView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Home _ Collection
    private func HomeViewHideOrShow(show: Bool) {
        if show == true {
            self.view.addSubview(self.collectionSegement)
            self.view.addSubview(self.homeHeader)
            
            UIView.animate(withDuration: 0.5) {
                // 메뉴바 숨기기
                self.menuHideOrShow(show: false, itemTapped: true, footerHide: true)

                // fontChangeHeader 테이블 보이게 하기
                self.homeHeader.alpha = 1
                self.homeHeader.frame.origin.y = 150
                
                // collectionSegement 테이블 보이게 하기
                self.collectionSegement.alpha = 1
                self.collectionSegement.frame.origin.y = 383
            }
            

        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                
                // fontChangeHeader 숨기기
                self.homeHeader.alpha = 0
                self.homeHeader.frame.origin.y = self.view.frame.height
                
                // collectionSegement 숨기기
                self.collectionSegement.alpha = 0
                self.collectionSegement.frame.origin.y = self.view.frame.height + 383

            } completion: { _ in
                // remove View
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
            self.view.addSubview(self.shopCollection)
            self.view.addSubview(self.detailView)
            self.view.bringSubviewToFront(self.blackView)
            
            UIView.animate(withDuration: 0.5) {
                // menuView 숨기기
                self.menuHideOrShow(show: false, itemTapped: true, footerHide: true)
                // shopCollection 보이게 하기
                self.shopCollection.alpha = 1
                self.shopCollection.frame.origin.y = 150
            }
            

        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // shopCollection 숨기기
                self.shopCollection.alpha = 0
                self.shopCollection.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // remove View
                self.shopCollection.removeFromSuperview()
                self.blackView.removeFromSuperview()
                self.detailView.removeFromSuperview()
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
                self.menuHideOrShow(show: false, itemTapped: true, footerHide: true)
                // setupTable 보이게 하기
                self.setupTableView.alpha = 1
                self.setupTableView.frame.origin.y = 150
            }
            
            
        // setup테이블 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // setupTable 숨기기
                self.setupTableView.alpha = 0
                self.setupTableView.frame.origin.y = self.view.frame.height
                
            } completion: { _ in
                // remove View
                self.setupTableView.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - Diary _ Table
    private func diaryTableHideOrShow(show: Bool) {
        // diary테이블뷰 보이게 하기
        if show == true {
            // diaryTable_View
            self.view.addSubview(self.diaryTable)
            
            UIView.animate(withDuration: 0.5) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                // diary테이블뷰 보이게 하기
                self.diaryTable.alpha = 1
                self.diaryTable.frame.origin.y = 150
            }
            
            
        // diary테이블뷰 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // diary테이블뷰 숨기기
                self.diaryTable.alpha = 0
                self.diaryTable.frame.origin.y = self.view.frame.height - 300

            } completion: { _ in
                // remove View
                self.diaryTable.removeFromSuperview()
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
                self.diaryTable.alpha = 0
                self.diaryTable.frame.origin.x = -self.view.frame.width
                // diaryVC 보이게 하기
                self.diaryVC.alpha = 1
                self.diaryVC.frame.origin.x = 0
            }
            
            
        // DiaryVC 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                // diarytableView 보이게 하기
                self.diaryTable.alpha = 1
                self.diaryTable.frame.origin.x = 0
                // diaryVC 숨기기
                self.diaryVC.alpha = 0
                self.diaryVC.frame.origin.x = self.view.frame.width

            } completion: { _ in
                // remove View
                self.diaryVC.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Detail_View + Black
    func detailViewHideOrShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                // detailBlackView 보이게 하기
                self.blackView.alpha = 1
                // detailview 보이게 하기
                self.detailView.alpha = 1
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // detailBlackView 보이게 하기
                self.blackView.alpha = 0
                // detailview 보이게 하기
                self.detailView.alpha = 0
            }
        }
    }
}


















































// MARK: - View Transition
// 뷰가 바뀌는 상황 (버튼을 누르는 상황 등)
    // 뷰 전환
    // 왼쪽 버튼의 역할 및 이미지를 바꿈
    // 상황에 따라 필요한 토글 설정
extension MainVC: HeaderMainDelegate, MenuMainDelegate, SecondMainDelegate, DiaryTableMainDelegate, ShopMainDelegate, FirstMainDelegate {
    
    // MARK: - Menu
    // MainVC -> MenuVC
    func handleMainToMenu() {
        self.blackViewToggle = .menu
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .menuViewButton
        // menu_View_보이게 하기
        self.menuHideOrShow(show: true, itemTapped: true, footerHide: false)
    }
    // Menu -> MainVC
    func handleMenuToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // Menu_View 숨기기
        self.menuHideOrShow(show: false, itemTapped: false, footerHide: false)
    }
    
    
    
    
    
    // MARK: - Achieve_View
    // menu -> achieveView
    func handleAchievement() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .achievementVCButton
        // collectionView의 토글을 바꿈
        self.collectionSegementView.collectionToggle = .achieve
        // achievement_View_보이게 하기
        self.achievementViewHideOrShow(show: true)
    }
    // AchieveView -> MainVC
    func handleAchievementToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // achievement_View_숨기기
        self.achievementViewHideOrShow(show: false)
    }
    
    
    
    
    
    // MARK: - Home_View
    // menu -> HomeView
    func handleHome() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .homeViewButton
        // collectionView의 토글을 바꿈
        self.collectionSegement.collectionToggle = .home
        // Home_View_보이게 하기
        self.HomeViewHideOrShow(show: true)
    }
    // Home -> Main
    func handleHomeToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // home_View_숨기기
        self.HomeViewHideOrShow(show: false)
    }
    
    
    
    
    
    // MARK: - Shop_View
    // menu -> ShopView
    func handleShop() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .shopVCButton
        // shop_View_보이게 하기
        self.shopViewHideOrShow(show: true)
    }
    // ShopVC -> MainVC
    func handleShopToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // shop_View_숨기기
        self.shopViewHideOrShow(show: false)
    }
    
    
    
    
    
    // MARK: - Setup_View
    // menu -> SetupView
    func handleSetup() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .setupVCButton
        // setup_Table_보이게 하기
        self.setupTableHideOrShow(show: true)
    }
    // SetupVC -> MainVC
    func handleSetupToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // setup_Table_숨기기
        self.setupTableHideOrShow(show: false)
    }
    
    
    
    
    
    // MARK: - Diary_Table
    // MainVC -> Diary_Table
    @objc private func starButtonTapped() {
        // 버튼의 이미지 바꾸기
            // header에서 바꾸면 diaryVC -> Diary_Table로 이동할 때도 애니메이션이 작동하므로 여기서 설정
        self.headerView.leftButtonAlpha(.back)
        // 버튼의 역할을 바꿈
        self.headerView.buttonConfig = .diaryTableViewButton
        // diary_Table_View_보이게 하기
        self.diaryTableHideOrShow(show: true)
    }
    // Diary_Table -> MainVC
    func handleTableToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // diary_Table_View_숨기기
        self.diaryTableHideOrShow(show: false)
    }
    
    
    
    
    
    // MARK: - DiaryVC
    // Diary_Table -> DiaryVC
    func handleTableToDiaryVC() {
        // 버튼의 이미지 + 역할을 바꿈 (위에서 바꾼 Toggle을 통해 right버튼도 바뀜)
        self.headerView.buttonConfig = .diaryViewButton
        // diary_View_보이게 하기
        self.DiaryViewHideOrShow(show: true)
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
    
    
    
    
    
    // MARK: - Detail_View
// [Achieve]
    // achieve -> Detail
        // second segement를 누르면 detail로 진입
    func secondTapped() {
        // detail_View + detail_Black_View 보이게 하기
        self.blackViewToggle = .achieve
        // left 버튼의 용도 바꾸기
        self.headerView.buttonConfig = .achieveDetailViewButton
        // detail_View + black_View 보이게 하기
        self.detailViewHideOrShow(show: true)
    }
    // detailView -> AchieveView
    func handleDetailToAchieve() {
        // left 버튼의 용도 바꾸기
        self.headerView.buttonConfig = .achievementVCButton
        // detail_View + black_View 숨기기
        self.detailViewHideOrShow(show: false)
    }
    
    
    
    
    
// [Shop]
    // Shop_View -> detail_View
    func shopCellTapped() {
        // detail_View + detail_Black_View 보이게 하기
        self.blackViewToggle = .shop
        // left 버튼의 용도 바꾸기
        self.headerView.buttonConfig = .shopDetailViewButton
        // detail_View + black_View 보이게 하기
        self.detailViewHideOrShow(show: true)
    }
    
    // detail_View -> Shop_View
    func handleDetailToShop() {
        // left 버튼의 용도 바꾸기
        self.headerView.buttonConfig = .shopVCButton
        // detail_View + black_View 숨기기
        self.detailViewHideOrShow(show: false)
    }
    
    
    
    
    
    
    
    // MARK: - Black_View
// [Shop / Achieve]
    // detail_View -> Shop
    // detail_View -> Achieve
    // detail_View -> Main
    @objc private func detailBlackViewTapped() {
        switch self.blackViewToggle {
        case .menu:
            // menu 숨기기
            self.menuHideOrShow(show: false, itemTapped: false, footerHide: false)
            // 버튼의 이미지 + 역할 바꾸기
            self.headerView.buttonConfig = .mainViewButton
            
            
        case .shop:
            self.headerView.buttonConfig = .shopVCButton
            
            
        case .achieve:
            self.headerView.buttonConfig = .achievementVCButton
        }
        
        
        self.detailViewHideOrShow(show: false)
    }
    
    
    
    
    // MARK: - FirstMainDelegate
    func monthDiaryTapped() {
        print(#function)
    }
}
