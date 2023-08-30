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
}
// Table_View
enum TableViewEnum {
    case diary
    case setup
}

//enum CollectionViewEnum {
//    case myStar
//    case shop
//}

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

//enum FontColor: String {
//    case red = "0"
//    case orange = "1"
//    case yellow = "2"
//    case green = "3"
//    case blue = "4"
//    case indigo = "5"
//    case violet = "6"
//
//    func returnString(rawValue: Int) -> String {
//        switch rawValue {
//        case 0: return "빨간색"
//        case 1: return "주황색"
//        case 2: return "노란색"
//        case 3: return "초록색"
//        case 4: return "파란색"
//        case 5: return "남색"
//        case 6: return "보라색"
//
//        default: return "빨간색"
//        }
//    }
//
//    static var selectedInt: Int?
//}


enum CurrentTime {
    case dawn
    case morning
    case sunset
    case night
}

enum SegementCollection {
    case first
    case second
    
    /*
     case shop
     case home
     */
}

enum BlackViewToggle {
    case menu
    case shop
    case achieve
    case logout
}


//enum SetupBtntitle: CustomStringConvertible {
//    case ON
//    case OFF
//
//    var description: String {
//        switch self {
//        case .ON: return "ON"
//        case .OFF: return "OFF"
//        }
//    }
//}

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


func fontColor(index: Int) -> UIColor {
    switch index {
    case 0: return UIColor.rgb(r: 1, g: 133, b: 14)
    case 1: return UIColor.rgb(r: 11, g: 1, b: 152)
    case 2: return UIColor.rgb(r: 41, g: 141, b: 14)
    case 3: return UIColor.rgb(r: 231, g: 201, b: 15)
    case 4: return UIColor.rgb(r: 101, g: 133, b: 13)
    case 5: return UIColor.rgb(r: 31, g: 31, b: 144)
    case 6: return UIColor.rgb(r: 255, g: 33, b: 199)
    case 7: return UIColor.rgb(r: 79, g: 201, b: 13)
    case 8: return UIColor.rgb(r: 61, g: 1, b: 13)
    case 9: return UIColor.rgb(r: 151, g: 1, b: 155)
    case 10: return UIColor.rgb(r: 144, g: 144, b: 144)
    case 11: return UIColor.rgb(r: 199, g: 199, b: 199)
    case 12: return UIColor.rgb(r: 12, g: 12, b: 12)
    default: return UIColor.rgb(r: 158, g: 190, b: 11)
    }
}



//func returnImage(index: Int) -> String {
//    switch index {
//    case 100: return "dawn1"
//    case 101: return "dawn2"
//    case 102: return "dawn3"
//
//    case 200: return "morning1"
//    case 201: return "morning2"
//    case 202: return "morning3"
//
//    case 300: return "sunset1"
//    case 301: return "sunset2"
//    case 302: return "sunset3"
//
//    case 400: return "night1"
//    case 401: return "night2"
//    case 402: return "night3"
//    default: return "dawn1"
//    }
//}

//struct backgroundImg {
//
//
//
//
//}

//enum BackgroundImage {
//    case dawn0
//    case dawn1
//    case dawn2
//
//    case morning0
//    case morning1
//    case morning2
//
//    case sunset0
//    case sunset1
//    case sunset2
//
//    case night0
//    case night1
//    case night2
//
//
//
//
//
//
//}
