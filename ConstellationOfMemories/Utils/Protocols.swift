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
// [Main]
    // MainVC -> MenuVC
    func handleMainToMenu()
// [Menu]
    // Menu -> MainVC
    func handleMenuToMain()
// [Diary_Table]
    // tableView -> MainVC
    func handleTableToMain()
// [Diary_View]
    // DiaryVC -> TableView
    func handleDiaryToTable()
    
// [Achieve]
    // Achieve -> Main
    func handleAchievementToMain()
    // Achieve -> Achieve_Diary_Table
    func achieveTableToAchieve()
    // Achieve_Diary_View -> Achieve_Diary_Table
    func achieveDiaryToTable()
// [Home]
    // Home -> Main
    func handleHomeToMain()
// [Shop]
    // Shop - > Main
    func handleShopToMain()
    // Detail_Shop -> Shop
    func handleDetailToShop()
    // Detail_Shop -> purchase
    func detailToPurchase()
    // purchase -> Detail_Shop
//    func purchaseTodetailShop()
// [Setup]
    // Setup -> Main
    func handleSetupToMain()
    // Logout -> Setup
    func handleLogoutToSetup()
}


protocol HeaderDiaryVCDelegate {
    func diaryFixMode(_ fixMode: Bool)
    func observationMode()
}

protocol MenuMainDelegate {
    func handleAchievement()
    func handleHome()
    func handleShop()
    func handleSetup()
}

protocol FirstMainDelegate {
    func monthDiaryTapped(month: String)
}

//protocol SecondMainDelegate {
//    func secondTapped()
//}


protocol DiaryTableMainDelegate {
    func handleTableToDiaryVC(rightBtnConfig: RightBtnTapImgChange)
    // Achieve -> Diary_View
    func achieveDiaryView(month: String, day: String)
}

protocol DiaryTableDiaryDelegate {
    func todayDiaryTrue(diaryData: Diary)
    func todayDiaryFalse()
    func achieveDiary(diaryString: String)
}



protocol ShopMainDelegate {
    func shopCellTapped(index: String)
}


// MARK: - Home_View
protocol SecondHomeDelegate {
    func homeSecondTapped(index: Int)
}
protocol FirstHomeDelegate {
    func homeFirstTapped(index: Int, backgroundImg: HaveImg)
}
protocol HeaderHomeDelegate {
    func checkButtonTapped()
}

protocol HomeMainDelegate {
    func imgChanged(currentTime: CurrentTime, img: String, font: Int)
//    func fontChanged(currentTime: CurrentTime, fontInt: Int)
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


//protocol AchieveTableMianDelegate {
//    func achieveTableCellTapped()
//}




protocol homeHeaderViewDelegate {
    func showCheckRightBtn()
    func hideRightBtn()
}


protocol PurchaseMainDelegate {
    func cancelTapped()
    func purchaseTapped()
}
