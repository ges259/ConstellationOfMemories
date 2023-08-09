//
//  Protocols.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation


protocol MainHeaderDelegate {
    // MainVC -> MenuVC
    func handleGoToMenuVC()
    // MenuVC -> MainVC
    func handleBackToMainVC()
    
    
    // tableView -> MainVC
    func handleDismiss()
    
    
    // Diary 과련
    // TableView -> DiaryVC
    func handleGoToDiaryVC()
    // DiaryVC -> TableView
    func handleBackToTableView()
    
    // DiaryVC -> Share!!!!!
    func handleShareButtonTapped()
}
