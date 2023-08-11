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
    private let headerView = HeaderView.shared
    // 메뉴
    private let menuVC = MenuVC()
    // 테이블뷰 토글
    private var setupOrDiaryToggle: TableViewEnum = .diary
    // 테이블 뷰 ( 리스트 뷰 )
    private let diaryTableView = UITableView()
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    private let diaryVC = DiaryVC()
    // MenuVC
        // 상점 뷰
    private var shopView: UICollectionView!
        // seteup_VC
    private var setupTableView = UITableView()
        // achivementVC
//    private var achivementView = UIView()
    
    
    // item
    private var item = [Int]()
    private var row = [Int]()
    
    
    
    var num: Int = 0
    
    
    
    // Layout을 변수 만들 때 한번에? (collectionView의 frame 등)
    // 메뉴뷰 / 다이어리 테이블뷰만 먼저 만들고 나머지는 나중에?
        // 먼저 필요한 것들
    
    
    
    
    
    // MARK: - Layout
    // UIButton
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 37, imageString: .moon)
            btn.addTarget(self, action: #selector(self.starButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    // UIImageView
    private lazy var backgroundImage: UIImageView = {
        return UIImageView(image: UIImage(named: "blueSky"))
    }()
    // menuBlackView
    // Menu가 열렸을 때 다른 영역을 터치하면 Menu가 닫히도록하기 위해 blackView 설정
    private lazy var menuBlackView : UIView = {
        let view = UIView()
            view.backgroundColor = .clear
            view.frame = CGRect(x: -self.view.frame.width,
                                y: 0,
                                width: self.view.frame.width,
                                height: self.view.frame.height)
        // blackView - add gesture
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.blackViewTapped))
            view.addGestureRecognizer(tap)
        return view
    }()
//    // UIView
//    private lazy var userInfoHeader: UserInfoHeader = {
//        let frame = CGRect(x: 0,
//                           y: 0,
//                           width: self.view.frame.width,
//                           height: 120)
//        let view = UserInfoHeader(frame: frame)
//        return view
//    }()
//
    private lazy var achievementView: AchievementView = {
        let view = AchievementView()
            view.frame = CGRect(x: 0,
                                y: self.view.frame.height - 150,
                                width: self.view.frame.width,
                                height: self.view.frame.height - 150)
        
        return view
    }()
    
    

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure
            // + header
            // + background Color
            // + UI - AutoLayout
            // + tableView
        self.configureMainVC()
    }
    
    
    
    
    
    // MARK: - Helper Functions
    
    
    
    
    
    
    
    
    
    // MARK: - API
    
    
    
    
    
    
    
    
    // MARK: - Configure UI
    private func configureMainVC() {
        self.view.addSubview(self.backgroundImage)
        // imageView (가장 아래에 깔려야 함)
        self.backgroundImage.anchor(top: self.view.topAnchor,
                              bottom: self.view.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              trailing: self.view.trailingAnchor)
        
        
        
        
        
        
        // 헤더뷰
        self.headerView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.view.frame.width,
                                       height: 150)
        self.headerView.mainHeaderDelegate = self
        self.view.addSubview(self.headerView)
        
        
        
        
        
        
        
        // UI - AutoLayout
        // footerButton
        self.view.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                   centerX: self.view)
        
        
        
        
        

        // MenuVC
        self.menuVC.mainMenuDelegate = self
        self.menuVC.frame = CGRect(x: 0,
                                   y: 150,
                                   width: 82,
                                   height: self.view.frame.height - 610)
        // MenuVC를 blackView에 삽입
            // blackView를 터치하여 사라지면(gesture) menu도 같이 사라짐
        
        self.menuBlackView.addSubview(self.menuVC)
        
        
        
        
        
        
        
        
        // 테이블뷰
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        
        self.diaryTableView.separatorStyle = .none
        self.diaryTableView.backgroundColor = .clear
        
        self.diaryTableView.register(DiaryTableViewCell.self,
                                forCellReuseIdentifier: ReuseIdentifier.diaryTableViewCell)
        self.diaryTableView.frame = CGRect(x: 0,
                                      y: self.view.frame.height,
                                      width: self.view.frame.width,
                                      height: self.view.frame.height - 150)
        
        
        
        
        
        
        
        
        // DiaryVC frame
        self.headerView.diaryHeaderDelegate = diaryVC
        self.diaryVC.alpha = 0
        self.diaryVC.frame = CGRect(x: self.view.frame.width,
                                    y: 150,
                                    width: self.view.frame.width,
                                    height: self.view.frame.height - 150)
        
        
        
        
        
        
        
        
        // Menu - Shop
        // collectionView
        let collectionViewFrame = CGRect(x: 0,
                           y: self.view.frame.height - 150,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 150)
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let interval:CGFloat = 30
            layout.sectionInset = UIEdgeInsets.init(top: interval,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        self.shopView = UICollectionView(frame: collectionViewFrame,
                                               collectionViewLayout: layout)
        self.shopView.delegate = self
        self.shopView.dataSource = self

        self.shopView.register(ShopCollectionViewCell.self,
                                     forCellWithReuseIdentifier: ReuseIdentifier.shopCell)

        self.shopView.alwaysBounceVertical = true
        self.shopView.backgroundColor = .clear
        
        
        
        
        
        
        
        
        // MARK: - Fix
        // tableView Header 추가
        
        // Menu - Setup
        // setupTableView
        let setupTableFrame = CGRect(x: 0,
                           y: self.view.frame.height - 300,
                           width: self.view.frame.width,
                           height: self.view.frame.height - 150)
        
        self.setupTableView = UITableView(frame: setupTableFrame)
        
        self.setupTableView.delegate = self
        self.setupTableView.dataSource = self
        
        self.setupTableView.separatorStyle = .none
        self.setupTableView.backgroundColor = .clear
        
        self.setupTableView.alpha = 0
        self.setupTableView.backgroundColor = .clear
        
        self.setupTableView.register(SetupTableviewCell.self,
                                     forCellReuseIdentifier: ReuseIdentifier.setupTableViewCell)
    }
}


























// MARK: - Hide_OR_Show

extension MainVC {
    
    // MARK: - Diary
    private func diaryTableHideOrShow(show: Bool) {
        // 테이블뷰 보이게 하기
        if show == true {
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .tableViewButton
            // tableView를 여러군데서 사용하다보니 enum으로 구분.
            self.setupOrDiaryToggle = .diary
            
            self.view.addSubview(self.diaryTableView)
            
            UIView.animate(withDuration: 0.5) {
                self.diaryTableView.alpha = 1
                self.diaryTableView.frame.origin.y = 150
                self.footerButton.alpha = 0
                self.diaryTableView.reloadData()
            }
            
            
        // 테이블뷰 숨기기
        } else {
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .mainViewButton
            
            UIView.animate(withDuration: 0.5) {
                self.diaryTableView.alpha = 0
                self.diaryTableView.frame.origin.y = self.view.frame.height
                self.footerButton.alpha = 1
            } completion: { _ in
                self.diaryTableView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Setup
    private func setupTableHideOrShow(show: Bool) {
        // setup테이블 보이게 하기
        if show == true {
            self.setupOrDiaryToggle = .setup
            
            self.view.addSubview(self.setupTableView)
//            self.setupTableView.addSubview(self.userInfoHeader)
            
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .setupVCButton
            
            UIView.animate(withDuration: 0.5) {
                // 메뉴뷰 숨기기
                self.menuHideOrShow(show: false)
                // 위치
                self.setupTableView.frame.origin.y = 150
                self.setupTableView.alpha = 1
                self.footerButton.alpha = 0
            }
            
            
        // setup테이블 숨기기
        } else {
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .mainViewButton
            
            UIView.animate(withDuration: 0.5) {
                // 위치 옮기기
                self.setupTableView.frame.origin.y = self.view.frame.height
                self.setupTableView.alpha = 0
                self.footerButton.alpha = 1
                
                
            } completion: { _ in
                self.setupTableView.removeFromSuperview()
//                self.userInfoHeader.removeFromSuperview()
            }
        }
    }
    
    
    
    
    
    // MARK: - Shop
    private func collectionViewHideOrShow(show: Bool) {
        // 컬렉션뷰 보이게 하기
        if show == true {
            self.view.addSubview(self.shopView)
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .shopVCButton
            
            UIView.animate(withDuration: 0.5) {
                self.shopView.alpha = 1
                self.shopView.frame.origin.y = 150
                self.footerButton.alpha = 0
                // 메뉴뷰 숨기기
                self.menuHideOrShow(show: false)
                
                
                // item이 항상 맨위로 가도록 설정
                let indexPath = IndexPath(item: self.item.count - 1, section: 0)
                self.shopView.scrollToItem(at: indexPath, at: .top, animated: true)
                self.shopView.reloadData()
            }


        // 컬렉션뷰 숨기기
        } else {
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .mainViewButton
            
            UIView.animate(withDuration: 0.5) {
                self.shopView.alpha = 0
                self.shopView.frame.origin.y = self.view.frame.height
                self.footerButton.alpha = 1
                
            } completion: { _ in
                self.shopView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Achievement
    private func achievementViewHideOrShow(show: Bool) {
        
        if show == true {
            
            
            // MARK: - Fix
            // achievement - 에 나갔다가 들어오면 0으로 고정되도록
            
            self.view.addSubview(self.achievementView)
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .achievementVCButton

            UIView.animate(withDuration: 0.5) {
                // menuView 숨기기
                self.menuHideOrShow(show: false)
                self.footerButton.alpha = 0
                self.achievementView.alpha = 1
                self.achievementView.frame.origin.y = 150
            }
        } else {
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .mainViewButton
            
            UIView.animate(withDuration: 0.5) {

                self.footerButton.alpha = 1

                self.achievementView.frame.origin.y = self.view.frame.height
                
                
                
            } completion: { _ in
                self.achievementView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - DiaryVC
    private func DiaryViewHideOrShow(show: Bool) {
        // DiaryVC 보이게 하기
        if show == true {
            // MARK: - Fix
            // 넘어갈 때 '오늘의 추억'이라면
                // -> fix모드로 진입
//            self.headerView.rightButtonConfig = .fixMode
            
            // 다른 날의 추억이라면
                // -> save모드로 진입
            
            
            
            
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .diaryViewButton
            
            // addSubView DiaryVC
            self.view.addSubview(self.diaryVC)
            // 화면에 보이게 하기
            UIView.animate(withDuration: 0.5) {
                self.diaryTableView.alpha = 0
                self.diaryVC.frame.origin.x = 0
                self.diaryVC.alpha = 1
            }
            
            
        // DiaryVC 숨기기
        } else {
            
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .tableViewButton
            
            
            UIView.animate(withDuration: 0.5) {
                self.diaryVC.alpha = 0
                self.diaryVC.frame.origin.x = self.view.frame.width
                self.diaryTableView.alpha = 1
            } completion: { _ in
                self.diaryVC.removeFromSuperview()
            }
        }
    }
    
    // MARK: - MenuVC _ blackView
    private func menuHideOrShow(show: Bool) {
        // 메뉴 보이게 하기
        if show == true {
            
            self.view.addSubview(self.menuBlackView)
            // 버튼의 이미지 + 역할을 바꿈
            self.headerView.buttonConfig = .menuViewButton
            // 메뉴 화면에 보이게 하기
            UIView.animate(withDuration: 0.5) {
                self.menuBlackView.frame.origin.x = 0
            }
            
            
        // 메뉴 숨기기
        } else {
            // menuHideOrShow(show: false)에는 buttonConfig가 없음
                // 메뉴에서 버튼을 클릭하면 menu(blackView)도 같이 false로 바뀌는데,
                    // 이 과정에서 buttonConfig = .mainViewButton이 늦게 호출되어
                        // setup, achieve, shop 등에서 오류가 발생
                            // 따라서 blackView를 탭하였을 때 한정으로 buttonConfig를 .MainViewButton으로바꿈
            UIView.animate(withDuration: 0.2) {
                self.menuBlackView.frame.origin.x = -self.view.frame.width
                
            } completion: { _ in
                self.menuBlackView.removeFromSuperview()
            }
        }
    }
}

























// MARK: - TableView_Delegate
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    // dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch setupOrDiaryToggle {
        case .diary:
            return 10
            
            
        case .setup:
            return 10
            
            
        case .achivement:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch setupOrDiaryToggle {
        case .diary:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.diaryTableViewCell,
                                                     for: indexPath) as! DiaryTableViewCell
            
            return cell
            
            
        case .setup:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.setupTableViewCell,
                                                     for: indexPath) as! SetupTableviewCell
                
            
                
            
            cell.textLabel?.text = String(self.num)
            num += 1
            return cell
            
            
        case .achivement:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.diaryTableViewCell,
                                                     for: indexPath) as! DiaryTableViewCell
            return cell
        }
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch setupOrDiaryToggle {
        case .diary:
            // handleBackToTableView() 에서 닫힘
            self.DiaryViewHideOrShow(show: true)
            
            
            
        case .setup:
            print(#function)
            break
            
            
            
        case .achivement:
            print(#function)
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch setupOrDiaryToggle {
            
        case .diary:
            return 140
            
            
        case .setup:
            return 140
            
            
        case .achivement:
            return 140
        }
    }
}




// MARK: - CollectionView_Delegate
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource,
                  UICollectionViewDelegateFlowLayout {
    // dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.shopCell, for: indexPath)

        return cell
    }
    
    // delegate
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 좌우 패딩 30 = 60
        // spacing = 30
        let width = (self.view.frame.width - 60 - 30) / 2
        let height = width / 10 * 16
        
        return CGSize(width: width, height: height)
    }
    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}





















// MARK: - View Transition
// 뷰가 바뀌는 상황 (버튼을 누르는 상황 등)
extension MainVC: MainHeaderDelegate {
    
    // MARK: - MainHeaderDelegate
    // Header의 Left_Button을 누르면 호출 됨
    
    // MainVC -> MenuVC
    func handleGoToMenuVC() {
        self.menuHideOrShow(show: true)
    }
    // tableView -> MainVC
    func handleDismiss() {
        self.diaryTableHideOrShow(show: false)
    }
    // DiaryVC -> TableView
    func handleBackToTableView() {
        self.DiaryViewHideOrShow(show: false)
    }
    // ShopVC -> MainVC
    func handleBackShopToMainVC() {
        self.collectionViewHideOrShow(show: false)
    }
    
    // SetupVC -> MainVC
    func handleBackSetupToMain() {
        self.setupTableHideOrShow(show: false)
    }
    // AchieveView -> MainVC
    func handleBackAchievementToMain() {
        self.achievementViewHideOrShow(show: false)
    }
    
    
    
    // MARK: - Selectors
    // 버튼을 누르는 상황 이외에 화면 변경
    
    // MenuVC -> MainVC
    @objc private func blackViewTapped() {
        self.menuHideOrShow(show: false)
        
        // menuHideOrShow(show: false)에는 buttonConfig가 없음
            // 메뉴에서 버튼을 클릭하면 menu(blackView)도 같이 false로 바뀌는데,
                // 이 과정에서 buttonConfig = .mainViewButton이 늦게 호출되어
                    // setup, achieve, shop 등에서 오류가 발생
                        // 따라서 blackView를 탭하였을 때 한정으로 buttonConfig를 .MainViewButton으로바꿈
        self.headerView.buttonConfig = .mainViewButton
    }
    
    // MainVC -> TableView
    @objc private func starButtonTapped() {
        self.diaryTableHideOrShow(show: true)
    }
}





// MARK: - MainMenuDelegate
// 메뉴에서 버튼을 눌렀을 때 호출 됨
extension MainVC: MainMenuDelegate {
    // menu -> achieveView
    func handleAchievement() {
        self.achievementViewHideOrShow(show: true)
    }
    // menu -> ShopView
    func handleShop() {
        self.collectionViewHideOrShow(show: true)
    }
    // menu -> SetupView
    func handleSetup() {
        self.setupTableHideOrShow(show: true)
    }
}
