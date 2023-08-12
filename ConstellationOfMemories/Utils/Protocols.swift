//
//  Protocols.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation


protocol MainHeaderDelegate {
    // MenuVC -> MainVC는 MainVC의 BlackView로 대체
    // MainVC -> MenuVC
    func handleGoToMenuVC()
    // tableView -> MainVC
    func handleDismiss()
    // TableView -> DiaryVC -> TableView Cell을 통해
    // DiaryVC -> TableView
    func handleBackToTableView()
    
    func handleBackShopToMainVC()
    
    func handleBackSetupToMain()
    
    func handleBackAchievementToMain()
}


protocol DiaryHeaderDelegate {
    func diaryFixMode(_ fixMode: Bool)
}

protocol MainMenuDelegate {
    func handleAchievement()
    func handleShop()
    func handleSetup()
}


protocol AchieveMainDelegate {
    func myStarSegement()
    func habitSegment()
}

