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
    
    
    
    // MARK: - Button
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 37, imageString: .star)
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
        // 헤더뷰 freme
        self.headerView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.view.frame.width,
                                       height: 150)
        // 헤더 뷰 + Delegate
        self.view.addSubview(self.headerView)
        self.headerView.mainHeaderDelegate = self
        
        
        // background Color
        self.view.backgroundColor = .systemGray4
        
        
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
        self.view.addSubview(self.tableView)
    }
}





// MARK: - Configure View

extension MainVC {
    
    // MARK: - TableView
    // 테이블뷰 숨기기 / 보이게 하기
    private func tableViewHideOrShow(show: Bool) {
        // 보이게 하기
        if show == true {
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 1
                self.tableView.frame.origin.y = 150
                self.footerButton.alpha = 0
                self.tableView.reloadData()
            }
            
            
        // 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 0
                self.tableView.frame.origin.y = self.view.frame.height
                self.footerButton.alpha = 1
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - DiaryVC
    // DiaryVC 숨기기 / 보이게 하기
    private func DiaryViewHideOrShow(show: Bool) {
        // 보이게 하기
        // 수정 뷰 (  셀 누르면 넘어가는 뷰 )
        if show == true {
            // DiaryVC 생성
            self.diaryVC.frame = CGRect(x: self.view.frame.width,
                                        y: 150,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height - 150)
            // delegate
            self.headerView.diaryHeaderDelegate = diaryVC
            self.view.addSubview(self.diaryVC)
            
            // 화면에 보이게 하기
            self.diaryVC.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 0
                self.diaryVC.alpha = 1
                self.diaryVC.frame.origin.x = 0
            }
            
            
        // 숨기기
        } else {
            UIView.animate(withDuration: 0.5) {
                self.diaryVC.alpha = 0
                self.tableView.alpha = 1
                self.diaryVC.frame.origin.x = self.view.frame.width
            }
            self.diaryVC.removeFromSuperview()
        }
    }
    
    // MARK: - MenuVC
    // 메뉴 숨기기 / 보이게 하기
    private func menuHideOrShow(show: Bool) {
        if show == true {
            // 함수로 만들어서 깔끔하게 하는 게 좋으려나..?
            // 아니면 그냥 다 여기다 다 적어버리는 게 좋으려나...
            // 다쓰면 되게 더러워질 거 같긴 한데..
            
            // configure blackView
            self.configureBlackView()
            // configure Menu
            self.configureMenuVC()
            
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
                // menuView 밑 blackView 삭제
                self.menuVC.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
    private func configureMenuVC() {
        self.menuVC.frame = CGRect(x: -self.view.frame.width,
                                   y: 150,
                                   width: 150,
                                   height: self.view.frame.height - 300)
        self.view.addSubview(self.menuVC)
        self.menuVC.alpha = 0
    }
    
    // MARK: - BlackView
    // Menu가 열렸을 때 다른 영역을 터치하면 Menu가 닫히도록하기 위해 blackView 설정
    private func configureBlackView() {
        self.blackView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: self.view.frame.width,
                                      height: self.view.frame.height)
        self.blackView.backgroundColor = .clear
        self.view.addSubview(self.blackView)
        
        // add gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.blackViewTapped))
        self.blackView.addGestureRecognizer(tap)
    }
}





// MARK: - View Transition
extension MainVC: MainHeaderDelegate {
    // MenuVC -> MainVC
    @objc private func blackViewTapped() {
        // 메뉴 뷰 숨기기
        // blackView 없애기
        // removeFromSuperView
        self.menuHideOrShow(show: false)
        // 버튼 이미지 변경
        self.headerView.buttonConfig = .mainLeftButton
    }
    // MainVC -> TableView
    @objc private func starButtonTapped() {
        // 테이블뷰 보이게
        self.tableViewHideOrShow(show: true)
        // left 버튼의 용도 바꾸기
            // menu -> back
        self.headerView.buttonConfig = .tableLeftButton
    }
    // MARK: - MainHeaderDelegate
    // MainVC -> MenuVC
    func handleGoToMenuVC() {
        // 메뉴 뷰 생성 + 보이게 하기
        // blackView 보이게 하기
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
        // 버튼의 역할 변경
        // 버튼 이미지 변경
        self.headerView.buttonConfig = .diaryLeftButton
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
