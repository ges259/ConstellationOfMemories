//
//  Enum.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation


// extension
enum FontStyle {
    case system
    case bold
    case AvenirLight
}

// HeaderView
enum RightHeaderButton {
    case tableRightButtonTapped
    case diaryRightButtonTapped
}
enum LeftHeaderButton {
    case menuLeftButtonTapped
        // dismiss
    case mainLeftButtonTapped
        // menu
    case tableLeftButtonTapped
        // dismiss
        // fix
    case diaryLeftButtonTapped
        // dismiss
        // share
    
}


// MainvC
enum TableViewEnum {
    case hide
    case show
}

