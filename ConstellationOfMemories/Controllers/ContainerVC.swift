//
//  ContainerVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit

final class ContainerVC: UIViewController {
    
    // MARK: - Properties
    // init을 쓴다면 아래와 같이 바꿔주고 나중에 생성해야함
        // private var menuController: MenuController!
    private let mainVC = MainVC()
    private let menuVC = MenuVC()
    // blackView를 누르면 MenuVC가 닫히도록
    private let blackView = UIView()
    
    // Menu가 열렸는 지 닫혔는 지 판단하는 변수
    private var isExpanded: Bool = false
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    // MARK: - HelperFunctions
    private func configureMenuVC() {
        
    }
    private func configureMainVC() {
        
    }
    
    
    
    // MARK: - Selectors
    
    
    
    
    // MARK: - API
    
    
}
