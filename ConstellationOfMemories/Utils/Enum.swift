//
//  Enum.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import Foundation
import UIKit


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
    case diaryTableViewButton
    case diaryViewButton
    case homeViewButton
    case shopVCButton
    case achieveDetailViewButton
    case shopDetailViewButton
    case setupVCButton
    case logoutSetupButton
    case achievementVCButton
}

enum RightBtnTapImgChange {
    case fixMode
    case saveMode
    case coin
    case achieveDetail
    case shopDetail
    case home
}
// Table_View
enum TableViewEnum {
    case diary
    case setup
}

// Collection_View
enum SegementToggle {
    case home
    case achieve
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
    case home
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
        case .home: return "house"
        case .shop: return "bag"
        case .coin :return "stop.circle.fill"
        }
    }
}

enum CurrentTime {
    case dawn
    case morning
    case sunset
    case night
}

enum SegementCollection {
    case first
    case second
}

enum BlackViewToggle {
    case menu
    case shop
    case achieve
    case logout
}

enum SetupCelltitle: CustomStringConvertible {
    case info
    case logout
    
    var description: String {
        switch self {
        case .info: return "알림"
        case .logout: return "로그아웃"
        }
    }
}
