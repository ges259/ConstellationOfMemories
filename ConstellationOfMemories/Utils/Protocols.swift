//
//  Protocols.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation

protocol SignUpLoginDelegate {
    func handleSignUpToLogin()
    func handleLogin()
}


protocol LoginMainDelegate {
    func handleLoginToMain()
}



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
    
    // Achieve -> Main
    func handleAchievementToMain()
    // Shop - > Main
    func handleShopToMain()
    // Setup -> Main
    func handleSetupToMain()
    // Home -> Main
    func handleHomeToMain()
    
    // [Detail]_Achieve -> Achieve
    func handleDetailToAchieve()
    // [Detail]_Shop -> Shop
    func handleDetailToShop()
    
    // Logout -> Setup
    func handleLogoutToSetup()
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
    func todayDiaryTrue(diaryData: Diary)
    func todayDiaryFalse()
}



protocol ShopMainDelegate {
    func shopCellTapped()
}


// MARK: - Home_View
protocol SecondHomeDelegate {
    func homeSecondTapped(index: Int)
}
protocol FirstHomeDelegate {
    func homeFirstTapped(index: Int, backgroundImg: BackgroundImg)
}
protocol HeaderHomeDelegate {
    func checkButtonTapped()
}

protocol HomeMainDelegate {
    func imgChanged(currentTime: CurrentTime, img: String)
    func fontChanged(currentTime: CurrentTime, fontInt: Int)
}



protocol SetupCellSetupDelegate {
    func logoutBtnTapped()
}





protocol LogoutMainDelegate {
    func cancelBtnTapped()
    func logoutBtnTapped()
}




protocol SetupMainDelegate {
    func cancelBtnTapped()
    func setupBlackViewShow()
}


protocol DiaryVCMainDelegate {
    func updateDiaryData()
}

protocol SetupInfoHeaderDelegate {
    func configInfoHeader(user: User?)
}




