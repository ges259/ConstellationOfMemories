//
//  Protocols.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation


protocol HeaderMainDelegate {
    // MenuVC -> MainVC는 MainVC의 BlackView로 대체
    // MainVC -> MenuVC
    func handleMainToMenu()
    // Menu -> MainVC
    func handleMenuToMain()
    // tableView -> MainVC
    func handleTableToMain()
    // TableView -> DiaryVC -> TableView Cell을 통해
    // DiaryVC -> TableView
    func handleDiaryToTable()
    
    func handleShopToMain()
    
    func handleDetailToAchieve()
    
    func handleDetailToShop()
    
    func handleSetupToMain()
    
    func handleHomeToMain()
    
    func handleAchievementToMain()
}


protocol HeaderDiaryVCDelegate {
    func diaryFixMode(_ fixMode: Bool)
}

protocol MenuMainDelegate {
    func handleAchievement()
    func handleHome()
    func handleShop()
    func handleSetup()
}

protocol FirstMainDelegate {
    func monthDiaryTapped()
}

protocol SecondMainDelegate {
    func secondTapped()
}


protocol DiaryTableMainDelegate {
    func handleTableToDiaryVC()
}

protocol DiaryTableDiaryDelegate {
    func todayDiaryTrue(diaryData: DiaryData)
    func todayDiaryFalse()
}



protocol ShopMainDelegate {
    func shopCellTapped()
}


// MARK: - Home_View
protocol FirstHomeHeaderDelegate {
    func fontColor()
}
protocol SecondHomeHeaderDelegate {
    func backgroundColr()
}

