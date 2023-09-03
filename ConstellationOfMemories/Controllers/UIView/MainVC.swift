//
//  MainVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import UIKit
import FirebaseAuth

final class MainVC: UIViewController {
    
// MARK: - Properties
    
    
    
    // MARK: - Singleton
    // Service 싱글톤
    private let service = Service.shared
    
    

    // MARK: - Data
    // User
    private var user: User?
    // Diary_Data
        // Diary_Table로   [Diary] 데이터 보내기
    private var diaryData: [Diary] = []
    // background
    private var backgroundImg: BackgroundImg? {
        didSet {
            self.achieveView.backgroundData = backgroundImg
            self.homeView.backgroundData = backgroundImg
            self.shopView.backgroundData = backgroundImg
        }
    }
    
    

    // MARK: - Toggle
    // Black_View_Toggle
    private var blackViewToggle: BlackViewToggle = .menu 
    
    
    
    // MARK: - Time
    // 현재 시간( 새벽 / 아침 / 노을 / 밤 )
    private var currentTime: CurrentTime? {
        didSet {
            // MARK: - Fix
            // Timer
            
        }
    }
    
    // 오늘의 시간
        // month / day / hour
    private var todayArray: [String] = []
    
    
    
    // MARK: - Static_Properties
    // Today_Diary_Toggle
        // 오늘 일기를 썻는지
    static var todayDiaryToggle: Bool = false
    // Font
    var currentFont: UIColor? {
        didSet {
            if let currentFont = currentFont {
                // Header_View
                self.headerView.headerColor(currentFont)
                // Main_View
                self.footerButton.tintColor = currentFont
                // Menu_View
                self.menuView.menuColor(currentFont)
                // Achieve_View
                self.achieveView.achieveColor(currentFont)
                // Home_View
                self.homeView.homeColor(currentFont)
                // shop_View
                
                // setup_View
                self.setupView.setupColor(currentFont)
                // Diary_Table
                self.diaryTable.diaryTableColor(currentFont)
                // Diary_View
                self.diaryView.diaryColor(currentFont)
                // Detail_View
                self.detailView.detailColor(currentFont)
                // Logout_View
                
            }
        }
    }
    
    
    
    
    
    
    // MARK: - Disposable_Properties
    // Background
//            let backgroundArray: [String] = self.settinglaunchImg()
//            self.backgroundImage.image = UIImage(named: backgroundArray[3])
    // Background
    var backgroundArray: [String]? {
        didSet {
            
        }
    }
            
    // Frame - (편의성)
    private lazy var width = self.view.frame.width
    private lazy var height = self.view.frame.height
    
    
    private var animateTime: Double = 0.5
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Layout
    
    
    
    // MARK: - ImageView
    private lazy var launchScreen1: LaounchSccreen = {
        let frame = CGRect(x: self.width * 2,
                           y: 0,
                           width: self.width,
                           height: self.height)
        return LaounchSccreen(frame: frame)
    }()
    private lazy var launchScreen2: LaounchSccreen = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.width,
                           height: self.height)
        return LaounchSccreen(frame: frame)
    }()
    
    // background
    private lazy var backgroundImage: UIImageView = {
        return UIImageView()
    }()
    
    
    
    // MARK: - Button
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 37, imageString: .moon)
            btn.alpha = 0
            btn.addTarget(self, action: #selector(self.starButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    
// MARK: - Views
    
    
    
    // MARK: - Header_View
    private lazy var headerView: HeaderView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.width,
                           height: 150)
        return HeaderView(frame: frame)
    }()
    
    
    
    // MARK: - Menu
    private lazy var menuView: MenuVC = {
        let frame = CGRect(x: -82,
                           y: 150,
                           width: 82,
                           height: self.view.frame.height - 500)
        let view = MenuVC(frame: frame)
            view.mainMenuDelegate = self
        return view
    }()
    
    
    
    // MARK: - Achievement
    private lazy var achieveView: AchieveView = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.width,
                           height: self.height - 150)
        let view = AchieveView(frame: frame)
            view.achieveMainDelegate = self
        return view
    }()
    
    
    
    // MARK: - Home_View
    private lazy var homeView: HomeView = {
        let headerFrame = CGRect(x: 0,
                                 y: 150,
                                 width: self.width,
                                 height: self.height)
        let view = HomeView(frame: headerFrame)
            view.homeMainDelegate = self
            view.homeHeaderDelegaet = self.headerView
        return  view
    }()
    
    
    
    // MARK: - Shop_View
    private lazy var shopView: ShopCollectionView = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.width,
                           height: self.height - 150)
        let view = ShopCollectionView(frame: frame)
            view.mainShopDelgate = self
        return view
    }()
    // MARK: - Shop_Detail
    private lazy var detailView: DetailView = {
        let frame = CGRect(x: 20,
                           y: 150,
                           width: self.width - 40,
                           height: self.width / 10 * 16)
        return DetailView(frame: frame)
    }()
    
    
    
    // MARK: - Setup_Table
    private lazy var setupView: SetupTableView = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.width,
                           height: self.height - 150)
        let view = SetupTableView(frame: frame)
            view.setupMainDelegate = self
        return view
    }()
    
    
    
    // MARK: - Diary_Table
    private lazy var diaryTable: DiaryTableView = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.width,
                           height: self.height - 150)
        let view = DiaryTableView(frame: frame)
            view.diaryTableMainDelegate = self
            view.diaryTableDiaryDelegate = self.diaryView
        return view
    }()
    
    
    
    // MARK: - DiaryVC
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    private lazy var diaryView: DiaryVC = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.width,
                           height: self.height - 150)
        let view = DiaryVC(frame: frame)
            view.diaryVCMainDelegate = self
        return view
    }()
    
    
    
    // MARK: - Black_View
    private lazy var blackView: UIView = {
        let frame = CGRect(x: 0,
                           y: 150,
                           width: self.width,
                           height: self.height)
        let view = UIView(frame: frame)
            view.backgroundColor = .clear
            view.alpha = 0
        // blackView - add gesture
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.detailBlackViewTapped))
            view.addGestureRecognizer(tap)
        return view
    }()
    
    
    // MARK: - Login_View
    private lazy var loginView: LoginVC = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.width,
                           height: self.height)
        let view = LoginVC(frame: frame)
            view.loginMainDelegate = self
        return view
    }()
    
    
    
    // MARK: - Logout_View
    // black_View + 로그아웃 창
    private lazy var logoutView: LogoutView = {
        let frame = CGRect(x: self.width / 6,
                           y: self.height / 5 * 2,
                           width: self.width / 3 * 2,
                           height: 150)
        let view = LogoutView(frame: frame)
            view.logoutMainDelegate = self
        return view
    }()
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     
    
    
    
    
    
    
    
    // MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // checkLogin
            // User가 있다면 -> launch_Screen -> MainVC
            // User가 없다면 -> launch_Screen -> Login_View
        self.checkLogin()
    }

    
    
// MARK: - Disposable_Properties
    
    
    
    // MARK: - launch_Screen
    private func launchScreen(completion: @escaping () -> Void) {
        // background_Image
        self.view.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(top: self.view.topAnchor,
                                    bottom: self.view.bottomAnchor,
                                    leading: self.view.leadingAnchor,
                                    trailing: self.view.trailingAnchor)
        self.view.addSubview(self.launchScreen1)
        self.view.addSubview(self.launchScreen2)
        
        
// blueSky
        UIView.animate(withDuration: 1.0) {
            // launchScreen1 위치 바꾸기
                // 처음 화면에서 1초를 기다리기 위한 꼼수...
                    // 아무 것도 없으면 animate가 안 되더라구........
            self.launchScreen1.frame.origin.x = self.width
            
            //  = ["100", "200", "300", "400"]
// backgroundArray[0]
        } completion: { _ in
            // launchScreen1 이미지 바꾸기
            self.launchScreen1.imageView.image = UIImage(named: self.backgroundArray?[0] ?? "100")
            
            UIView.animate(withDuration: 0.5) {
                // launchScreen1 보이게 하기
                self.launchScreen1.frame.origin.x = 0
                // launchScreen2 숨기기
                self.launchScreen2.frame.origin.x = -self.width
                
                
// backgroundArray[1]
            } completion: { _ in
                // launchScreen2 이미지 바꾸기
                self.launchScreen2.imageView.image = UIImage(named: self.backgroundArray?[1] ?? "200")
                // launchScreen2 위치 바꾸기
                self.launchScreen2.frame.origin.x = self.width

                UIView.animate(withDuration: 0.5) {
                    // launchScreen1 숨기기
                    self.launchScreen1.frame.origin.x = -self.width
                    // launchScreen2 보이게 하기
                    self.launchScreen2.frame.origin.x = 0
                    
                    
// backgroundArray[2]
                } completion: { _ in
                    // launchScreen1 이미지 바꾸기
                    self.launchScreen1.imageView.image = UIImage(named: self.backgroundArray?[2] ?? "300")
                    // launchScreen1 위치 바꾸기
                    self.launchScreen1.frame.origin.x = self.width
                    
                    UIView.animate(withDuration: 0.5) {
                        // launchScreen1 보이게 하기
                        self.launchScreen1.frame.origin.x = 0
                        // launchScreen2 숨기기
                        self.launchScreen2.frame.origin.x = -self.width
                        
                        
// backgroundArray[3]
                    } completion: { _ in
                        if self.backgroundArray == nil { sleep(3) }
                        
                        self.backgroundImage.image = UIImage(named: self.backgroundArray?[3] ?? "400")
                        
                        // launchScreen1 이미지 바꾸기
                        self.launchScreen2.imageView.image = UIImage(named: self.backgroundArray?[3] ?? "400")
                        // launchScreen1 위치 바꾸기
                        self.launchScreen2.frame.origin.x = self.width
                        
                        UIView.animate(withDuration: 0.5) {
                            // launchScreen1 숨기기
                            self.launchScreen1.frame.origin.x = -self.width
                            // launchScreen2 보이게 하기
                            self.launchScreen2.frame.origin.x = 0
                            
                            
// background_Image
                        } completion: { _ in
                            UIView.animate(withDuration: 0.1) {
                                self.launchScreen2.alpha = 0
                                
                                
// removeFromSuperView()
                            } completion: { _ in
                                completion()
                                // remove_View
                                self.launchScreen1.removeFromSuperview()
                                self.launchScreen2.removeFromSuperview()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    // MARK: - launch_Image
    private func settinglaunchImg() {
        guard let hour = Int(self.todayArray[2]),
              let user = self.user
        else { return }
        
        // MARK: - Fix
        if hour < 7 {
            self.backgroundArray = [user.morningImg, user.sunsetImg, user.nightImg, user.dawnImg]
            self.currentTime = .dawn
            self.currentFont = fontColor(index: user.dawnFont)
            
        } else if 7 <= hour && hour < 18 {
            self.backgroundArray = [user.sunsetImg, user.nightImg, user.dawnImg, user.morningImg]
            self.currentTime = .morning
            self.currentFont = fontColor(index: user.dawnFont)
            
        } else if 18 <= hour && hour < 19 {
            self.backgroundArray = [user.nightImg, user.dawnImg, user.morningImg, user.sunsetImg]
            self.currentTime = .sunset
            self.currentFont = fontColor(index: user.dawnFont)
            
        } else if 19 <= hour && hour <= 24 {
            self.backgroundArray = [user.dawnImg, user.morningImg, user.sunsetImg, user.nightImg]
            self.currentTime = .night
            self.currentFont = fontColor(index: user.dawnFont)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

// MARK: - Helper_Functions
    
    
    
    // MARK: - Authentication
    // user가 있는지 확인
    private func checkLogin() {
        // user가 있다면 -> MainVC 로 이동
        if Auth.auth().currentUser?.uid != nil {
            // header 및 footer_Button 구현
            self.launchScreen { self.configureMainVC() }
            // 시간 업데이트
            self.updateTime()
            // User_Dat와 Diary_Data - 가져오기
            self.fetchUserData()
            self.fetchDiaryDatas()
            self.fetchBackgroundImg()
            
            
        // user가 없다면 -> Login_View 로 이동
            // Login_View 보이게 하기
        } else { self.launchScreen { self.loginViewShow(true) } }
    }
    
    
    
    // MARK: - Update_Time
    private func updateTime() {
        // Date_Formatter
        let dateFormatter = DateFormatter()
        let date = Date()
            // month
            dateFormatter.dateFormat = "M"
        let month = dateFormatter.string(from: date)
            // day
            dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: date)
            // hour
            dateFormatter.dateFormat = "H"
        let hour = dateFormatter.string(from: date)
        
        // todayArray 업데이트
        self.todayArray = [month, day, hour]
    }
    
    
    
    // MARK: - Today_Diary_Toggle
    private func todayDiaryWritten(datas: [Diary]) {
        // First_Day
        guard let diaryfirstDay = datas.first?.day else { return }
        
        // todayDairyToggle 설정
            // Today와 Last_Day를 비교
                // -> 같으면 true
                // -> 다르면 false
        MainVC.todayDiaryToggle = self.todayArray[1] == diaryfirstDay
            ? true
            : false
        // Diary_Data에 데이터 저장
        self.diaryData = datas
    }
    
    
    
    // MARK: - Configure UI
    private func configureMainVC() {
        // header_View
        self.view.addSubview(self.headerView)
        self.headerView.mainHeaderDelegate = self
        self.headerView.diaryHeaderDelegate = self.diaryView
        self.headerView.headerHomeDelegate = self.homeView
        
        
        
        // footer_Button
        self.view.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                 centerX: self.view)
        
        
        
        // Main_View_Layout 보이게 하기
        UIView.animate(withDuration: 1) {
            self.headerView.alpha = 1
            self.footerButton.alpha = 1
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - API
    
    
    
    // MARK: - Fetch_Background_Img
    private func fetchBackgroundImg() {
        self.service.fetchBackground { [self] array in
            self.backgroundImg = array
        }
    }
    
    
    
    // MARK: - Fetch_User_Data
    private func fetchUserData() {
        self.service.fetchUserData() { user in
            self.user = user
            
            // 첫 fetch_User에서만 작동
            if self.backgroundArray == nil { self.settinglaunchImg() }
        }
    }
    
    
    
    // MARK: - Fetcj_Diary_Data
    private func fetchDiaryDatas() {
        // Diary_Data를 가져오기
            // 로그아웃 -> 다른 아이디로 로그인 시 버그,
                // 좀 어지럽네
        self.service.fetchDiaryDatas(month: self.todayArray[0]) { datas in
            // 일기를 하나도 안 쓴 사람.
            if datas == nil {
                MainVC.todayDiaryToggle = false
                // diaryData에 데이터 넣기
                self.diaryData = []
                
                
            // 일기를 1개라도 썻다면 (diary_날짜 데이터가 있음)
            } else {
                guard let datas = datas else { return }
                // 오늘 일기를 썻는지 안 썻는지 확인
                self.todayDiaryWritten(datas: datas)
                
                self.diaryTable.diaryData = self.diaryData
            }
        }
    }
}


















































// MARK: - View Transition

extension MainVC {
    
    // MARK: - MenuVC _ View
    private func menuShow(_ show: Bool, itemTapped: Bool, footerHide: Bool) {
        // 메뉴 보이게 하기
        if show == true {
            self.view.addSubview(self.blackView)
            self.view.addSubview(self.menuView)
            
            UIView.animate(withDuration: 0.3) {
                // menuBlackView 보이게 하기
                self.blackView.alpha = 1
                self.menuView.alpha = 1
                self.menuView.frame.origin.x = 0
            }
            
            
        // 메뉴 숨기기
        } else {
            // 메뉴 -> 메뉴 안의 아이템을 클릭하지 않고 main화면으로 다시 돌아간다면
                // detail_Black_View 삭제
                    // 이렇게 한 이유는: 다음 화면(ahieve/shop)에서 detail_Black_View를 사용.
                        // - 하지만 여기서 뷰를 삭제해버린다면 (ahieve/shop)에서 안 뜸.
            // true: (backButton / Black_View_Tapped)
            // false: (achieve/home/shop/setup)으로 들어가면
            if itemTapped == false { self.blackView.removeFromSuperview() }
            
            UIView.animate(withDuration: 0.25) {
                // menuBlackView 숨기기
                self.blackView.alpha = 0
                self.menuView.alpha = 0
                self.menuView.frame.origin.x = -82
                // footer 버튼 숨기기
                if footerHide == true { self.footerButton.alpha = 0 }
                
            } completion: { _ in
                self.menuView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Achievement _ Collection
    private func achievementViewShow(_ show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            self.view.addSubview(self.achieveView)
            
            // menuView 숨기기
            self.menuShow(false, itemTapped: true, footerHide: true)
            
            UIView.animate(withDuration: self.animateTime) {
                // achievementView 보이게 하기
                self.achieveView.alpha = 1
            }
            
            
        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // achievementView 숨기기
                self.achieveView.alpha = 0
                
            } completion: { _ in
                self.achieveView.resetAchieveView()
                // remove View
                
                self.achieveView.removeFromSuperview()
            }
        }
    }
    // MARK: - Achieve_Diary_Table
    private func achieveTableShow(_ show: Bool) {
        // achieve_Table_View 보이게 하기
        if show == true {
            self.view.addSubview(self.diaryTable)
            self.view.addSubview(self.diaryView)
            
            UIView.animate(withDuration: self.animateTime) {
                // achieve_View 숨기기
                self.achieveView.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // diary_Table 보이게 하기
                    self.diaryTable.alpha = 1
                }
            }
            
            
        // achieve_Table_View 숨기기
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // diary_Table 숨기기
                self.diaryTable.alpha = 0
                
            } completion: { _ in
                
                UIView.animate(withDuration: self.animateTime) {
                    // achieve_View 보이게 하기
                    self.achieveView.alpha = 1
                    
                } completion: { _ in
                    self.diaryTable.removeFromSuperview()
                    self.diaryView.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    // MARK: - Ahieve_Diary_View
    private func achieveDiaryViewShow(_ show: Bool) {
        if show == true {
            UIView.animate(withDuration: self.animateTime) {
                // diaryTable 숨기기
                self.diaryTable.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // diaryView 보이게 하기
                    self.diaryView.alpha = 1
                }
            }
            

        } else {
            UIView.animate(withDuration: self.animateTime) {
                // diaryView 숨기기
                self.diaryView.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // diaryTable 보이게 하기
                    self.diaryTable.alpha = 1
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Home _ Collection
    private func HomeViewShow(_ show: Bool) {
        // Home_View 보이게 하기
        if show == true {
            self.view.addSubview(self.homeView)
            
            // 메뉴바 숨기기
            self.menuShow(false, itemTapped: true, footerHide: true)
            
            UIView.animate(withDuration: self.animateTime * 2) {
                // fontChangeHeader 테이블 보이게 하기
                self.homeView.alpha = 1
            }
            
        // Home_View 숨기기
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // fontChangeHeader 숨기기
                self.homeView.alpha = 0

            } completion: { _ in
                // reset Home_View
                self.homeView.resetHomeView()
                // remove View
                self.homeView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Shop _ Collection
    private func shopViewShow(_ show: Bool) {
        // achievementView 보이게 하기 - CollectionView
        if show == true {
            self.view.addSubview(self.shopView)
            self.view.addSubview(self.detailView)
            self.view.bringSubviewToFront(self.blackView)
            
            // menuView 숨기기
            self.menuShow(false, itemTapped: true, footerHide: true)
            
            UIView.animate(withDuration: self.animateTime * 2) {
                // shopCollection 보이게 하기
                self.shopView.alpha = 1
            }
            

        // achievementView 숨기기 - CollectionView
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // shopCollection 숨기기
                self.shopView.alpha = 0
                
            } completion: { _ in
                // remove View
                self.shopView.removeFromSuperview()
                self.blackView.removeFromSuperview()
                self.detailView.removeFromSuperview()
            }
        }
    }
    // MARK: - Shop_Detail
    private func detailViewShow(_ show: Bool) {
        // detailView 보이게 하기
        if show == true {
            UIView.animate(withDuration: self.animateTime) {
                // detail_View에 집중할 수 있도록 숨기기
                self.shopView.alpha = 0
                // detailBlackView 보이게 하기
                self.blackView.alpha = 1
                // detailview 보이게 하기
                self.detailView.alpha = 1
            }
        
            
        // detailView 숨기기
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // shop_View 원상복구
                self.shopView.alpha = 1
                // detailBlackView 보이게 하기
                self.blackView.alpha = 0
                // detailview 보이게 하기
                self.detailView.alpha = 0
            }
        }
    }
    
    
    
    // MARK: - Setup _ Table
    private func setupTableShow(_ show: Bool) {
        // setup테이블 보이게 하기
        if show == true {
            self.view.addSubview(self.setupView)
            
            // 메뉴뷰 숨기기
            self.menuShow(false, itemTapped: true, footerHide: true)
            
            UIView.animate(withDuration: self.animateTime * 2) {
                // setupTable 보이게 하기
                self.setupView.alpha = 1
            }
            
            
        // setup테이블 숨기기
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                // setupTable 숨기기
                self.setupView.alpha = 0
                
            } completion: { _ in
                // remove View
                self.setupView.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - Diary _ Table
    private func diaryTableShow(_ show: Bool) {
        // diary테이블뷰 보이게 하기
        if show == true {
            self.view.addSubview(self.diaryTable)
            
            UIView.animate(withDuration: self.animateTime) {
                // footerButton 숨기기
                self.footerButton.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // diary테이블뷰 보이게 하기
                    self.diaryTable.alpha = 1
                }
            }
            
            
        // diary테이블뷰 숨기기
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // diary테이블뷰 숨기기
                self.diaryTable.alpha = 0

            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // footerButton 보이게 하기
                    self.footerButton.alpha = 1
                    
                } completion: { _ in
                    // remove View
                    self.diaryTable.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    // MARK: - DiaryVC _ View
    private func DiaryViewShow(_ show: Bool) {
        // Diary_View 보이게 하기
        if show == true {
            self.view.addSubview(self.diaryView)

            UIView.animate(withDuration: self.animateTime) {
                // diary_table_View 숨기기
                self.diaryTable.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // diaryVC 보이게 하기
                    self.diaryView.alpha = 1
                }
            }
            
            
        // Diary_View 숨기기
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // diaryVC 숨기기
                self.diaryView.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTime) {
                    // diary_table_View 보이게 하기
                    self.diaryTable.alpha = 1
                    
                } completion: { _ in
                    // remove View
                    self.diaryView.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    // MARK: - Login_View
    private func loginViewShow(_ show: Bool) {
        // Login_View_Show
        if show == true {
            self.view.addSubview(self.loginView)
            
            // login_View 보이게 하기
            UIView.animate(withDuration: 2) {
                self.loginView.alpha = 1
                
            } completion: { _ in
                self.headerView.removeFromSuperview()
                self.footerButton.removeFromSuperview()
            }
            
            
        // Login_View_Hide
        } else {
            UIView.animate(withDuration: 0.3) {
                // login_View 숨기기
                self.loginView.alpha = 0
                // MainVC_Layout 보이게 하기
                self.headerView.alpha = 1
                self.footerButton.alpha = 1
                
            } completion: { _ in
                self.configureMainVC()
                self.loginView.resetLoginView()
                self.loginView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Logout_View
    private func logoutViewShow(_ show: Bool) {
        if show == true {
            self.view.addSubview(self.blackView)
            self.view.addSubview(self.logoutView)
            
            UIView.animate(withDuration: self.animateTime) {
                // setup_View 숨기기
                self.setupView.alpha = 0.3
                // login_View 보이게 하기
                self.logoutView.alpha = 1
                // Black_View 보이게 하기
                self.blackView.alpha = 1
            }
            
            
        } else {
            UIView.animate(withDuration: self.animateTime) {
                // setup_View 보이게 하기
                self.setupView.alpha = 1
                // login_View 숨기기
                self.logoutView.alpha = 0
                // Black_View 숨기기
                self.blackView.alpha = 0
                
            } completion: { _ in
                self.logoutView.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
}


















































// MARK: - View Config
// 뷰가 바뀌는 상황 (버튼을 누르는 상황 등)
    // 뷰 전환
    // 왼쪽 버튼의 역할 및 이미지를 바꿈
    // 상황에 따라 필요한 토글 설정
extension MainVC: LoginMainDelegate, HeaderMainDelegate, MenuMainDelegate, FirstMainDelegate, DiaryTableMainDelegate, ShopMainDelegate, SetupMainDelegate, LogoutMainDelegate {
    
    // MARK: - Menu
// [Left_Button]
    // MainVC -> MenuVC
    func handleMainToMenu() {
        self.blackViewToggle = .menu
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .menuViewButton
        // menu_View_보이게 하기
        self.menuShow(true, itemTapped: true, footerHide: false)
    }
// [Left_Button]
    // Menu -> MainVC
    func handleMenuToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // Menu_View 숨기기
        self.menuShow(false, itemTapped: false, footerHide: false)
    }
    
    
    
    // MARK: - Achieve_View
// [Menu - Button]
    // menu -> achieveView
    func handleAchievement() {
        service.fetchDiaryMonth(completion: { months in
            self.achieveView.everyMonth = months
        })
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .achieveViewButton
        // achievement_View_보이게 하기
        self.achievementViewShow(true)
    }
// [Left_Button]
    // AchieveView -> MainVC
    func handleAchievementToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // achievement_View_숨기기
        self.achievementViewShow(false)
    }
    
    
    
    // MARK: - Achieve_Dairy_Table
// [Collection_Cell]
    // Achieve_View -> Achieve_Table
    func monthDiaryTapped(month: String) {
        self.diaryTable.diaryTableEnum = .achieve
        
        self.service.fetchDiaryDatas(month: month) { datas in
            if let datas = datas { self.diaryTable.diaryData = datas }
            // 버튼의 역할을 바꿈
            self.headerView.buttonConfig = .achieveTableButton
            self.headerView.headerTitle(title: "\(month)월의 일기장")
            // achieve_Table 보이게 하기
            self.achieveTableShow(true)
        }
    }
// [Left_Button]
    // Achieve_Table -> Achieve_View
    func achieveTableToAchieve() {
        // 버튼의 역할을 바꿈
        self.headerView.buttonConfig = .achieveViewButton
        // achieve_Table 보이게 하기
        self.achieveTableShow(false)
    }
    
    
    
    
    
    
    
    // MARK: - Achieve_Diary_View
// [Table_Cell]
    // Achieve_Diary_TAble -> Diary_View
    func achieveDiaryView(month: String, day: String) {
        self.headerView.headerTitle(title: "\(month)월 \(day)일의 일기장")
        // 버튼의 역할 바꾸기
        self.headerView.buttonConfig = .achieveDiaryVeiwButton
        // achieve_Diary_View 숨기기
        self.achieveDiaryViewShow(true)
    }
// [Left_Button]
    // Achieve_Diary_View -> Achieve_Diary_Table
    func achieveDiaryToTable() {
        // MARK: - Fix
        // 이거보다 더 좋은 방법이 있지 않을까?????
        let month = self.diaryTable.diaryData[0].month
        self.headerView.headerTitle(title: "\(month)월의 일기장")
        // 버튼의 역할 바꾸기
        self.headerView.buttonConfig = .achieveTableButton
        // achieve_Diary_View 숨기기
        self.achieveDiaryViewShow(false)
    }
    
    
    
    
    
    
    // MARK: - Home_View
// [Menu - Button]
    // menu -> HomeView
    func handleHome() {
        // user 전달
        self.homeView.user = self.user
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .homeViewButton
        // Home_View_보이게 하기
        self.HomeViewShow(true)
    }
    
// [Left_Button]
    // Home -> Main
    func handleHomeToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // home_View_숨기기
        self.HomeViewShow(false)
        // fetch_User
        self.fetchUserData()
    }
    
    
    
    // MARK: - Shop_View
// [Menu - Button]
    // menu -> ShopView
    func handleShop() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .shopVCButton
        // shop_View_보이게 하기
        self.shopViewShow(true)
    }
    
// [Left_Button]
    // ShopVC -> MainVC
    func handleShopToMain() {
        // titleLabel 바꾸기
        self.headerView.headerTitle(title: "상점")
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // shop_View_숨기기
        self.shopViewShow(false)
    }
    
    
// [Shop_Detail_View]
    // [Item]
        // Shop_View -> detail_View
        func shopCellTapped(index: String) {
            // 이미지 바꾸기
            self.detailView.detailBackground.image = UIImage(named: index)
            
            // detail_View + detail_Black_View 보이게 하기
            self.blackViewToggle = .shop
            // left 버튼의 용도 바꾸기
            self.headerView.buttonConfig = .shopDetailViewButton
            // detail_View + black_View 보이게 하기
            self.detailViewShow(true)
        }
        
    // [Left_Button]
        // detail_View -> Shop_View
        func handleDetailToShop() {
            // left 버튼의 용도 바꾸기
            self.headerView.buttonConfig = .shopVCButton
            // detail_View + black_View 숨기기
            self.detailViewShow(false)
        }
    
    
    
    // MARK: - Setup_View
// [Menu - Button]
    // menu -> SetupView
    func handleSetup() {
        self.setupView.user = self.user
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .setupVCButton
        // setup_Table_보이게 하기
        self.setupTableShow(true)
    }
// [Left_Button]
    // SetupVC -> MainVC
    func handleSetupToMain() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // setup_Table_숨기기
        self.setupTableShow(false)
    }
    
    
    
    // MARK: - Diary_Table
// [Footer_Button]
    // MainVC -> Diary_Table
    @objc private func starButtonTapped() {
        // diary_Toggle을 바꿈
        self.diaryTable.diaryTableEnum = .dirayTable
        // diaryData를 옮기기
        self.diaryTable.diaryData = self.diaryData
        // 버튼의 이미지 바꾸기
            // header에서 바꾸면 diaryVC -> Diary_Table로 이동할 때도 애니메이션이 작동하므로 여기서 설정
        self.headerView.leftButtonAlpha(.back)
//        self.headerView.headerTitle(title: "일기 목록")
        // 버튼의 역할을 바꿈
        self.headerView.buttonConfig = .diaryTableViewButton
        // diary_Table_View_보이게 하기
        self.diaryTableShow(true)
    }
    
// [Left_Button]
    // Diary_Table -> MainVC
    func handleTableToMain() {
//        self.headerView.animateTime = 0.5
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .mainViewButton
        // diary_Table_View_숨기기
        self.diaryTableShow(false)
    }
    
    
    
    // MARK: - DiaryView
// [Cell]
    // Diary_Table -> DiaryVC
    func handleTableToDiaryVC(rightBtnConfig: RightBtnTapImgChange) {
        self.headerView.rightButtonConfig = rightBtnConfig
        // 버튼의 이미지 + 역할을 바꿈 (위에서 바꾼 Toggle을 통해 right버튼도 바뀜)
        self.headerView.buttonConfig = .diaryViewButton
        // diary_View_보이게 하기
        self.DiaryViewShow(true)
    }
    
// [Left_Button]
    // DiaryVC -> Diary_Table
    func handleDiaryToTable() {
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .diaryTableViewButton
        // diary_View_숨기기
            // didSelect_Row_At()에서 열림
        self.DiaryViewShow(false)
    }
    
    
    

    
    
    
    // MARK: - Black_View_Tapped
// [Black_View - Tapped]
    // detail_View -> Shop
    // detail_View -> Achieve
    // detail_View -> Main
    // detail_View -> Setup
    @objc private func detailBlackViewTapped() {
        switch self.blackViewToggle {
        case .menu:
            // menu 숨기기
            self.menuShow(false, itemTapped: false, footerHide: false)
            // 버튼의 이미지 + 역할 바꾸기
            self.headerView.buttonConfig = .mainViewButton
            break
            
            
        case .shop:
            self.headerView.buttonConfig = .shopVCButton
            self.detailViewShow(false)
            break
            
            
        case .achieve:
            self.headerView.buttonConfig = .achieveViewButton
//            self.achieveDetailHideOrShow(show: false)
            break
            
            
        case .logout:
            self.headerView.buttonConfig = .setupVCButton
            self.logoutViewShow(false)
            break
        }
    }
    
    
    
    // MARK: - Login_View
// [Login_View - Button]
// [SignUp_View - Button]
    // login_View -> Main
    func handleLoginToMain() {
        // Login_View 숨기기
        self.loginViewShow(false)
        // fetch_User & fetch_Diary
        self.fetchUserData()
        self.fetchDiaryDatas()
    }
    
    
    
    // MARK: - Logout_View
// [Cell - Button]
    // setup_View -> Logout_View(BlackView)
    func setupBlackViewShow() {
        // blackViewToggle 바꾸기
        self.blackViewToggle = .logout
        // left 버튼의 역할 바꾸기
        self.headerView.buttonConfig = .logoutSetupButton
        // Logout_Veiw 보이게 하기
        self.logoutViewShow(true)
    }
    
// [Left_Button]
    // Logout_View(BlackView) -> Setup_View
    func handleLogoutToSetup() {
        self.headerView.buttonConfig = .setupVCButton
        self.logoutViewShow(false)
    }
    
// [Logout_View - Button]
// [Black_View]
    // Logout_View(BlackView) -> Setup_View
    func cancelBtnTapped() {
        self.headerView.buttonConfig = .setupVCButton
        self.logoutViewShow(false)
    }
    
// [Logout_View(BlackView) - Button]
    // Logout
    func logoutBtnTapped() {
        // logout_View에서 나가기
        self.logoutViewShow(false)
        // setup_View 숨기기
        self.setupTableShow(false)
        // left 버튼의 용도 및 이미지 바꾸기
        self.headerView.buttonConfig = .mainViewButton
        
        UIView.animate(withDuration: 0.3) {
            // header_View + fotter_Button 숨기기
            self.headerView.alpha = 0
            self.footerButton.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                do {
                    // 로그아웃
                    try Auth.auth().signOut()
                    // MainVC로 이동
                    DispatchQueue.main.async {
                        // 배열 비우기
                        self.diaryData = []
                        // user 비우기
                            // 그래야 checkLogin()을 했을 때 로그아웃이 됨
                        self.user = nil
                        // login_View 보이게 하기
                        self.loginViewShow(true)
                    }
                } catch { print("DEBUG: Error signin out") }
            }
        }
    }
}















// MARK: - DiaryVCMainDelegate
extension MainVC: DiaryVCMainDelegate {
    func updateDiaryData() { self.fetchDiaryDatas() }
}





// MARK: - HomeMainDelegate
// Home_View에서 이미지 -> check버튼 누름
    // -> 현재 시간대가 맞다면 이미지가 바뀜
extension MainVC: HomeMainDelegate {
    func imgChanged(currentTime: CurrentTime, img: String) {
        if self.currentTime == currentTime {
            self.backgroundImage.image = UIImage(named: img)
        }
    }
    func fontChanged(currentTime: CurrentTime, fontInt: Int) {
        if self.currentTime == currentTime {
            self.currentFont = fontColor(index: fontInt)
        }
    }
}
