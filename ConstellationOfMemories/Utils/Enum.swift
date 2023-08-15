//
//  Enum.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation


// extension - UILabel
enum FontStyle {
    case system
    case bold
    case AvenirLight
}
// Header
enum LeftBtnTapImgChange {
    case menuViewButton
    case mainViewButton
    case tableViewButton
    case diaryViewButton
    case shopVCButton
    case setupVCButton
    case achievementVCButton
    case additionalTableView
}

enum RightBtnTapImgChange {
    case fixMode
    case saveMode
    case coin
}

enum TableViewEnum {
    case diary
    case setup
    case additional
}
enum CollectionViewEnum {
    case myStar
    case shop
}


enum imageString: CustomStringConvertible {
    case back
    case menu
    case fix
    case share
    case moon
    case check
    case setup // 설정
    case person
    case star // Main - Footer
    case achievement // 달성률
    case shop // 상점
    case coin // 코인 - rightButton
    
    var description: String {
        switch self {
        case .back: return "arrowshape.backward"
        case .menu: return "line.3.horizontal"
        case .fix: return "square.and.pencil"
        case .share: return "square.and.arrow.up"
        case .moon: return "moon.stars"
        case .check: return "checkmark"
        case .setup: return "gearshape"
        case .person: return "person"
        case .star: return "star"
        case .achievement: return "star.circle"
        case .shop: return "homekit"
        case .coin :return "stop.circle.fill"
        }
    }
}



// Addtional_Table_View
enum AddtionalEnum {
    case diaryTime
    case backgroundColor
    case Font
}

