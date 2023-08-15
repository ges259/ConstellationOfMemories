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
    
    
    
    
    
    // MARK: - Fix
    // Layout을 변수 만들 때 한번에? (collectionView의 frame 등을 achievementView, menuBlackView 처럼)
    
    // 먼저 필요한 것들(메뉴뷰 / 다이어리 테이블뷰)만 먼저 호출하고(만들고) 나머지는 나중에 호출??
    
    
    
    
    
    
    // MARK: - Views
    // 메뉴
    private let menuVC = MenuVC()
    // 테이블 뷰 ( 리스트 뷰 )
    private let diaryTableView = UITableView()
    // 테이블뷰 토글
    private var tableViewToggle: TableViewEnum = .diary
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    private var diaryVC = DiaryVC()
    // MenuVC
        // 상점 뷰 및 achivementVC
    private lazy var achievementView: collectionSegementView = {
        let view = collectionSegementView()
            view.frame = CGRect(x: 0,
                                y: self.view.frame.height - 300,
                                width: self.view.frame.width,
                                height: self.view.frame.height - 150)
            view.segementMainDelegate = self
        view.alpha = 0
        
        return view
    }()
    // seteup_VC
    private var setupTableView = UITableView()
    private var additionalTableView = UITableView()
    private var additionalEnum: AddtionalEnum = .diaryTime

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
    // UIView
    private lazy var userInfoTableHeader: UserInfoTableHeader = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
        let view = UserInfoTableHeader(frame: frame)
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    // MARK: - Layout
    // UIImageView
    private lazy var backgroundImage: UIImageView = {
        return UIImageView(image: UIImage(named: "blueSky"))
    }()
    
    // UIButton
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 37, imageString: .moon)
            btn.addTarget(self, action: #selector(self.starButtonTapped), for: .touchUpInside)
        return btn
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
        self.headerView.diaryHeaderDelegate = diaryVC
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
        self.diaryTableView.alpha = 0
        
        self.diaryTableView.register(DiaryTableViewCell.self,
                                forCellReuseIdentifier: ReuseIdentifier.diaryTableViewCell)
        self.diaryTableView.frame = CGRect(x: 0,
                                           y: self.view.frame.height - 300,
                                           width: self.view.frame.width,
                                           height: self.view.frame.height - 150)
        
        
        
        // DiaryVC frame
        self.diaryVC.mainDiaryDelegate = self
        self.diaryVC.alpha = 0
        self.diaryVC.frame = CGRect(x: self.view.frame.width - 150,
                                    y: 150,
                                    width: self.view.frame.width,
                                    height: self.view.frame.height - 150)
        
        
        
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
        
        self.setupTableView.register(SetupTableviewCell.self,
                                     forCellReuseIdentifier: ReuseIdentifier.setupTableViewCell)
        // setupTableview - headerView 추가
        self.setupTableView.tableHeaderView = userInfoTableHeader
        self.setupTableView.isScrollEnabled = false
        
        
        
        // MARK: - CoreData
        // 코어데이터에서 데이터 가져오기
        self.diaryData = coreData.readDiaryDatas()
        
        
        
        
        
        
        
        
        
        // setupAdditionalTableView
        let additinalTableFrame = CGRect(x: self.view.frame.width,
                                         y: 150,
                                         width: self.view.frame.width,
                                         height: self.view.frame.height - 150)
        self.additionalTableView = UITableView.init(frame: additinalTableFrame)
        
        self.additionalTableView.delegate = self
        self.additionalTableView.dataSource = self
        
        self.additionalTableView.isScrollEnabled = false
        self.additionalTableView.separatorStyle = .none
        self.additionalTableView.backgroundColor = .clear
        self.additionalTableView.alpha = 0
        
        self.additionalTableView.register(AdditionalCell.self, forCellReuseIdentifier: ReuseIdentifier.additionalCell)
        
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
                self.setupTableView.frame.origin
                    .y = 150
                self.setupTableView.alpha = 1
                // footerButton 숨기기
                self.footerButton.alpha = 0
            }
            
            
        // setup테이블 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                // setupTable 숨기기
                self.setupTableView.frame.origin.y = self.view.frame.height
                self.setupTableView.alpha = 0
                // footerButton 보이게 하기
                self.footerButton.alpha = 1
                
            } completion: { _ in
                // remove View
                self.setupTableView.removeFromSuperview()
            }
        }
    }
    
    
    
    // MARK: - Additional
    private func additionalTableHideOrShow(show: Bool) {
        if show == true {
            
            self.view.addSubview(self.additionalTableView)
            
            UIView.animate(withDuration: 0.5) {
                // setupTable 숨기기
                self.setupTableView.alpha = 0
                self.setupTableView.frame.origin.x = -self.view.frame.width
                
                // additaional 테이블 보이게 하기
                self.additionalTableView.alpha = 1
                self.additionalTableView.frame.origin.x = 0
                
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                
                // setupTable 보이게 하기
                self.setupTableView.alpha = 1
                self.setupTableView.frame.origin.x = 0
                
                // additaional 숨기기
                self.additionalTableView.alpha = 0
                self.additionalTableView.frame.origin.x = self.view.frame.width
                
            } completion: { _ in
                self.additionalTableView.removeFromSuperview()
            }
            
        }
    }
    
    
    
    
    
    
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
            // MARK: - Fix
            // tableView - didSelect_Row_At에서 해야할 듯
            // 넘어갈 때 '오늘의 추억'이라면
                // -> fix모드로 진입

            
            // 다른 날의 추억이라면
                // -> save모드로 진입
            
            
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
            
            UIView.animate(withDuration: 0.5) {
                // menuBlackView 보이게 하기
                self.menuBlackView.frame.origin.x = 0
            }
            
        // 메뉴 숨기기
        } else {
            UIView.animate(withDuration: 0.2) {
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
        self.headerView.buttonConfig = .tableViewButton
        
        self.diaryData = self.coreData.readDiaryDatas()
        self.diaryTableView.reloadData()
        
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
        self.additionalTableHideOrShow(show: false)
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
        // 버튼의 이미지 + 역할을 바꿈
        self.headerView.buttonConfig = .tableViewButton
        // tableView를 여러군데서 사용하다보니 enum으로 구분.
        self.tableViewToggle = .diary
        // diary_Table_View_보이게 하기
        self.diaryTableHideOrShow(show: true)
    }
    
    
    // MARK: - Helper Functions
        // 원래는 tableView-didSelectRowAt에 있지만 (.diary)
            // 일관성을 위한 함수 설정
    // Diary_Table -> DiaryVC
    private func tableToDiary() {
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
        case .additional: return 1
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
            
        case .additional: return nil
        }
    }
    
    
    
    
    
    
    
    
        
    
    // MARK: - Cell
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableViewToggle {
        case .diary: return 140
        case .setup: return 60
        case .additional: return 50
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
            
            
        case .additional:
            if self.additionalEnum == .diaryTime { return 12}
            else if self.additionalEnum == .backgroundColor { return 6 }
            else { return 3 }
        }
    }
    
    
    
    // cell_For_Row_At
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
            
            
        case .additional:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.additionalCell, for: indexPath) as! AdditionalCell
            
                cell.textLabel?.text = "11111"
            
            return cell
        }
    }
    
    
    
    // didSelect_Row_At
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
            
            
            self.diaryTableView.reloadData()
            // 뷰 전환 (일관성을 위해 함수로 만들어 둠)
            self.tableToDiary()
            break
            
            
        case .setup:
            // enum변경
            if indexPath.section == 0 {
                self.additionalEnum = .diaryTime
                print(additionalEnum)
            } else if indexPath.section == 1 {
                self.additionalEnum = .backgroundColor
                print(additionalEnum)
            } else {
                self.additionalEnum = .Font
                print(additionalEnum)
            }
            
            // 테이블뷰 토글 바꾸기
            self.tableViewToggle = .additional
            
            // 헤더의 버튼 이미지 + 설정 바꾸기
            self.headerView.buttonConfig = .additionalTableView
            
            // 셀의 개수가 달라지기 때문에 reloadData를 해줌
            self.additionalTableView.reloadData()
            
            // additional_Table_View 보이게 하기
            self.additionalTableHideOrShow(show: true)
            break
            
            
        case .additional:
            print(#function)
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    // 헤더 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            // background Color
            headerView.contentView.backgroundColor = UIColor(white: 1, alpha: 0.2)
            // section 헤더의 글자색 바꾸기
            headerView.textLabel?.textColor = .nightFontColor
        }
    }
}
