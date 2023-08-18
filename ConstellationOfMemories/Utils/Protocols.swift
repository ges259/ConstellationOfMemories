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
    func handleMainToMenu()
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


protocol DiaryHeaderDelegate {
    func diaryFixMode(_ fixMode: Bool)
}

protocol MainMenuDelegate {
    func handleAchievement()
    func handleHome()
    func handleShop()
    func handleSetup()
}

//protocol MainDiaryDelegate {
//    func todayDiaryCompleted()
//}

//protocol FirstMainDelegate {
//    func firstTapped()
//}

protocol SecondMainDelegate {
    func secondTapped()
}


protocol MainDiaryTableDelegate {
    func handleTableToDiaryVC()
}

protocol DiaryVCTableDelegate {
    func todayDiaryTrue(diaryData: DiaryData)
    func todayDiaryFalse()
}



protocol MainShopDelegate {
    func shopCellTapped()
}
