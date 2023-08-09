////
////  ContainerVC.swift
////  ConstellationOfMemories
////
////  Created by 계은성 on 2023/08/08.
////
//
//import UIKit
//
//final class ContainerVC: UIViewController {
//
//    // MARK: - Properties
//    // init을 쓴다면 아래와 같이 바꿔주고 나중에 생성해야함
//        // private var menuController: MenuController!
//    private let mainVC = MainVC()
//    private let menuVC = MenuVC()
//    // blackView를 누르면 MenuVC가 닫히도록
//    private let blackView = UIView()
//
//    // Menu가 열렸는 지 닫혔는 지 판단하는 변수
//    private var isExpanded: Bool = false
//
//    //
//    private lazy var xOrigin = self.view.frame.width - 80
//
//
//
//    // MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // configure
//        self.configureMainVC()
//        self.configureMenuVC()
//    }
//
//
//
//    // MARK: - Configure View
//    private func configureMainVC() {
//        self.mainVC.containerDelegate = self
//
//        self.addChild(self.mainVC)
//        self.mainVC.didMove(toParent: self)
//        self.view.addSubview(self.mainVC.view)
//    }
//    private func configureMenuVC() {
//        // 메뉴 뷰
//        self.menuVC.view.frame = CGRect(x: 0,
//                                        y: 0,
//                                        width: self.view.frame.width,
//                                        height: self.view.frame.height)
//        self.addChild(self.menuVC)
//        self.menuVC.didMove(toParent: self)
//        //  뷰에 계층 구조를 만듦
//        self.view.insertSubview(self.menuVC.view, at: 0)
//        self.configureBlackView()
//
//    }
//    private func configureBlackView() {
//        // color = .clear
//        self.blackView.backgroundColor = .clear
//        self.blackView.frame = CGRect(x: 0,
//                                      y: 0,
//                                      width: self.view.frame.width,
//                                      height: self.view.frame.height)
//        self.blackView.alpha = 0
//        self.view.addSubview(self.blackView)
//        // add gesture
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.blackViewTapped))
//        self.blackView.addGestureRecognizer(tap)
//    }
//
//
//
//
//    // MARK: - HelperFunctions
//    // move Menu
//    private func animateMenu(show: Bool) {
//        // 메뉴 보이게 하기
//        if show == true {
//            UIView.animate(withDuration: 0.5) {
//                // menu 옮기기
//                self.mainVC.view.frame.origin.x = self.xOrigin
//
//                // animate_blackView
//                self.animateBlackView(show: true)
//
//            }
//
//        // 숨기기
//        } else {
//            UIView.animate(withDuration: 0.5) {
//                // menu 옮기기
//
//                self.mainVC.view.frame.origin.x = 0
//
//                // animate_blackView
//                self.animateBlackView(show: false)
//            }
//        }
//    }
//    // move BlackView
//    private func animateBlackView(show: Bool) {
//
//        if show == true {
//            self.blackView.alpha = 1
//            self.blackView.frame.origin.x = self.xOrigin
//        } else {
//            self.blackView.alpha = 0
//            self.blackView.frame.origin.x = 0
//        }
//
//
//    }
//
//
//
//
//
//
//    // MARK: - Selectors
//    @objc private func blackViewTapped() {
//        self.animateMenu(show: false)
//    }
//
//
//
//
//
//
//    // MARK: - API
//
//
//
//
//
//    var menuToggle: Bool = true
//}
//
//
//
//// MARK: - MainVCDelegate
//extension ContainerVC: MainVCDelegate {
//    func handleMenuButton() {
//
//
//            // 메뉴 오픈
//        self.animateMenu(show: true)
//
//
//
//    }
//}
//
