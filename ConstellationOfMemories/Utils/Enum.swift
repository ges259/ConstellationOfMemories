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
    case menuLeftButton
    case mainLeftButton
    case tableLeftButton
    case diaryLeftButton
}

enum imageString: CustomStringConvertible {
    case back
    case menu
    case fix
    case share
    case star
    case check
    
    var description: String {
        switch self {
        case .back: return "arrowshape.backward"
        case .menu: return "line.3.horizontal"
        case .fix: return "square.and.pencil"
        case .share: return "square.and.arrow.up"
        case .star: return "moon.stars"
        case .check: return "checkmark"
        }
    }
}





