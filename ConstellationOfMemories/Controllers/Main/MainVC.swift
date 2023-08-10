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
    // blackView
    private let blackView = UIView()
    // 테이블 뷰 ( 리스트 뷰 )
    private let tableView = UITableView()
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    private let diaryVC = DiaryVC()
    // 상점 뷰
//    private var collectionView: UICollectionView!
    
    
    
    
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
        
        // configure
            // + header
            // + background Color
            // + UI - AutoLayout
            // + tableView
        self.configureMainVC()
    }
    
    
    
    
    // MARK: - Helper Functions
    
    
    
    
    
    
    
    
    
    // MARK: - API
    
    
    
    
    // UIImageView
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "blueSky")
        
        
        return iv
    }()
    
    
    
    // MARK: - Configure UI
    private func configureMainVC() {
        // imageView (가장 아래에 깔려야 함)
        self.view.addSubview(self.backgroundImage)
        self.backgroundImage.anchor(top: self.view.topAnchor,
                              bottom: self.view.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              trailing: self.view.trailingAnchor)
        // 헤더뷰 freme
        self.headerView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.view.frame.width,
                                       height: 150)
        // 헤더 뷰 + Delegate
        self.headerView.mainHeaderDelegate = self
        self.view.addSubview(self.headerView)
        
        
        // UI - AutoLayout
        self.view.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                   centerX: self.view)
        
        
        // 테이블뷰
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        
        self.tableView.register(DiaryCollectionCell.self,
                                forCellReuseIdentifier: ReuseIdentifier.DiaryCollectionCell)
        self.tableView.frame = CGRect(x: 0,
                                      y: self.view.frame.height,
                                      width: self.view.frame.width,
                                      height: self.view.frame.height - 150)
        
        
        
        // MenuVC
        self.menuVC.mainMenuDelegate = self
        self.menuVC.alpha = 0
        self.menuVC.frame = CGRect(x: -self.view.frame.width,
                                   y: 150,
                                   width: 82,
                                   height: self.view.frame.height - 610)
        
        
        
        // blackView
        self.blackView.backgroundColor = .clear
        self.blackView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: self.view.frame.width,
                                      height: self.view.frame.height)
        // DiaryVC frame
        self.headerView.diaryHeaderDelegate = diaryVC
        self.diaryVC.alpha = 0
        self.diaryVC.frame = CGRect(x: self.view.frame.width,
                                    y: 150,
                                    width: self.view.frame.width,
                                    height: self.view.frame.height - 150)
        // collectionView
//        let frame = CGRect(x: 0,
//                           y: self.view.frame.height,
//                           width: self.view.frame.width,
//                           height: self.view.frame.height - 150)
//        let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .vertical
//        self.collectionView = UICollectionView(frame: frame,
//                                               collectionViewLayout: layout)
//
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//
//
//        self.collectionView.register(ShopCell.self,
//                                     forCellWithReuseIdentifier: ReuseIdentifier.shopCell)
//
//        self.collectionView.alwaysBounceVertical = true
//        self.collectionView.backgroundColor = .blue
//
//        self.view.addSubview(self.collectionView)
    }
}





// MARK: - Configure View

extension MainVC {
    
    // MARK: - TableView
    private func tableViewHideOrShow(show: Bool) {
        // 테이블뷰 보이게 하기
        if show == true {
            
            self.view.addSubview(self.tableView)
            
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 1
                self.tableView.frame.origin.y = 150
                self.footerButton.alpha = 0
                self.tableView.reloadData()
            }
            
            
        // 테이블뷰 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 0
                self.tableView.frame.origin.y = self.view.frame.height
                self.footerButton.alpha = 1
                self.tableView.reloadData()
            } completion: { _ in
                self.tableView.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: - CollectionView
//    private func collectionViewHideOrShow(show: Bool) {
//        // 테이블뷰 보이게 하기
//        if show == true {
//
//
//            UIView.animate(withDuration: 0.5) {
//                self.collectionView.alpha = 1
//                self.collectionView.frame.origin.y = 150
//                self.footerButton.alpha = 0
//                self.menuHideOrShow(show: false)
//                self.collectionView.reloadData()
//            }
//
//
//        // 테이블뷰 숨기기
//        } else {
//            UIView.animate(withDuration: 0.5) {
//                self.collectionView.alpha = 0
//                self.collectionView.frame.origin.y = self.view.frame.height
//                self.footerButton.alpha = 1
//                self.menuHideOrShow(show: true)
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    
    
    
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
            
            
            // addSubView DiaryVC
            self.view.addSubview(self.diaryVC)
            // 화면에 보이게 하기
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 0
                self.diaryVC.frame.origin.x = 0
                self.diaryVC.alpha = 1
            }
            
            
        // DiaryVC 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                self.diaryVC.alpha = 0
                self.diaryVC.frame.origin.x = self.view.frame.width
                self.tableView.alpha = 1
            } completion: { _ in
                self.diaryVC.removeFromSuperview()
            }
        }
    }
    
    // MARK: - MenuVC
    private func menuHideOrShow(show: Bool) {
        // 메뉴 보이게 하기
        if show == true {
            self.configureBlackView()
            self.view.addSubview(self.menuVC)
            // 메뉴 화면에 보이게 하기
            UIView.animate(withDuration: 0.5) {
                self.menuVC.alpha = 1
                self.menuVC.frame.origin.x = 0
            }
            
            
        // 메뉴 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                self.menuVC.frame.origin.x = -self.view.frame.width
                self.menuVC.alpha = 0
            } completion: { _ in
                self.menuVC.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
    
    // MARK: - BlackView
    // Menu가 열렸을 때 다른 영역을 터치하면 Menu가 닫히도록하기 위해 blackView 설정
    private func configureBlackView() {
        self.view.addSubview(self.blackView)
        // add gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.blackViewTapped))
        self.blackView.addGestureRecognizer(tap)
    }
}





// MARK: - TableView
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    // dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.DiaryCollectionCell,
                                                 for: indexPath) as! DiaryCollectionCell
        
        
        return cell
    }
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // handleBackToTableView() 에서 닫힘
        self.DiaryViewHideOrShow(show: true)
        // 버튼의 역할 변경 + 버튼 이미지 변경
        self.headerView.buttonConfig = .diaryViewButton
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}




// MARK: - CollectionView
//extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.shopCell, for: indexPath)
//
//        return cell
//    }
//
//
//
//
//
//
//
//
//
//
//
//}





// MARK: - View Transition

extension MainVC: MainHeaderDelegate {
    
    // MARK: - Selectors
    // MenuVC -> MainVC
    @objc private func blackViewTapped() {
        // 메뉴 뷰 숨기기 ( blackView 없애기 + removeFromSuperView)
        self.menuHideOrShow(show: false)
        // 오로지 버튼 이미지 변경 ( dismiss는 다른 곳에서 )
        self.headerView.buttonConfig = .mainViewButton
    }
    // MainVC -> TableView
    @objc private func starButtonTapped() {
        // 테이블뷰 보이게
        self.tableViewHideOrShow(show: true)
        // left 버튼의 용도 바꾸기 ( menu -> back )
        
        self.headerView.buttonConfig = .tableViewButton
    }
    
    // MARK: - MainHeaderDelegate
    // MainVC -> MenuVC
    func handleGoToMenuVC() {
        // 메뉴 뷰 생성 + 메뉴 보이게 하기 (+ blackView )
        self.menuHideOrShow(show: true)
    }
    // tableView -> MainVC
    func handleDismiss() {
        self.tableViewHideOrShow(show: false)
    }
    // DiaryVC -> TableView
    func handleBackToTableView() {
        // didSelectRowAt에서 true
        self.DiaryViewHideOrShow(show: false)
    }
}










// MARK: - MainMenuDelegate
extension MainVC: MainMenuDelegate {
    func handleAchievement() {
        print(#function)
    }
    
    func handleShop() {
        print(#function)
        
        
        
        
        
    }
    
    func handleSetup() {
        print(#function)
    }
}
