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

    
    
    
    
    
    // MARK: - ddddd
// ***** 슈퍼 뷰 삭제 뭐 이런 거 있던데 한 번 찾아보기
    // 헤더 뷰
    private lazy var headerView: HeaderView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.width,
                           height: 150)
        let view = HeaderView(frame: frame)
        return view
    }()
    // 메뉴 뷰
    
    
    // 테이블 뷰 ( 리스트 뷰 )
    private let tableView = UITableView()
    private var tableViewEnum: TableViewEnum = .hide
    
    // 셀을 누르면 오른쪽 옆에서 나올 뷰 ( 수정 뷰 )
    
    
    
    // MARK: - Button
    private lazy var calendarButton: UIButton = {
        let btn = UIButton()
        // 버튼 시스템 이미지 크기 바꾸기
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .default)
        let largeBoldDoc = UIImage(systemName: "moon.stars", withConfiguration: largeConfig)
            btn.setImage(largeBoldDoc, for: .normal)
            btn.tintColor = .white
            btn.addTarget(self, action: #selector(self.calendarButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure
            // background Color
            // tableView
            // UI - AutoLayout
        self.configureMainVC()
    }
    
    
    
    // MARK: - Helper Functions
    private func configureMainVC() {
        // 헤더 뷰 + Delegate
        self.view.addSubview(self.headerView)
        self.headerView.mainHeaderDelegate = self
        // right Button 숨기기
        self.headerView.rightButton.isHidden = true

        
        // background Color
        self.view.backgroundColor = .systemGray4
        
        // UI - AutoLayout
        self.view.addSubview(self.calendarButton)
        self.calendarButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
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
                                      height: self.view.frame.height - 100)
        self.view.addSubview(self.tableView)
        
        // 셀 누르면 넘어가는 뷰 ( 수정 뷰 )
        
        
    }
    
    
    
    // 테이블뷰 숨기기 / 보이게 하기
    private func hideOrShowTableView(show: Bool) {
        self.tableViewEnum = show ? .show : .hide
        
        switch tableViewEnum {
        case .hide:
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 0
                self.tableView.frame.origin.y = self.view.frame.height
                self.calendarButton.isHidden = false
//                self.tableView.reloadData()
            }
            
            
        case .show:
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
                self.tableView.frame.origin.y = 150
                self.calendarButton.isHidden = true
//                self.tableView.reloadData()
            }
        }
    }
    // 상단 버튼 (left / right - Button)
    // headerView의 버튼의 역할을 바꾼는 메서드
    private func configureLeftHeaderButton(leftButton: LeftHeaderButton) {
        self.headerView.leftHeaderButton = leftButton
    }
    private func configureRightHeaderButton(rightButton: RightHeaderButton) {
        self.headerView.rightHeaderButton = rightButton
    }
    
    // MARK: - Selectors
    @objc private func calendarButtonTapped() {
        // 테이블뷰 보이게
            // 위에서 테이블뷰가 올라옴
        self.hideOrShowTableView(show: true)
        // right 버튼 보이게 하기 ( tableView에서는 rightView가 보이게 )
//        self.headerView.rightButton.isHidden = false
        
        // left 버튼의 용도 바꾸기
            // menu -> back
                // talbe에서 MainVC로 돌아올 수 있도록
        self.configureLeftHeaderButton(leftButton: .tableLeftButtonTapped)
    }
    
    
    
    // MARK: - API
    
    
    
    
    
    
    
    
    
    
    
    
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
        print(#function)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}



// MARK: - MainHeaderDelegate
extension MainVC: MainHeaderDelegate {
    // MainVC -> MenuVC
    func handleGoToMenuVC() {
        print(#function)
    }
    // MenuVC -> MainVC
    func handleBackToMainVC() {
        print(#function)
    }
    // tableView -> MainVC
    func handleDismiss() {
        print(#function)
        self.hideOrShowTableView(show: false)
    }
    // TableView -> DiaryVC
    func handleGoToDiaryVC() {
        print(#function)
    }
    // DiaryVC -> TableView
    func handleBackToTableView() {
        print(#function)
    }
    // DiaryVC -> Share!!!!!
    func handleShareButtonTapped() {
        print(#function)
    }
}


