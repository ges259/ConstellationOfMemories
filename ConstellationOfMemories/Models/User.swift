//
//  User.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/21.
//

struct User {
    // 기본 설정들
    let uid: String
    let fullName: String
    let email: String
    // 알림 설정
    let noti: Int
    
    // 글자 색상
    let dawnFont: Int
    let morningFont: Int
    let sunsetFont: Int
    let nightFont: Int
    
    // 배경 화면
    let dawn: String
    let morning: String
    let sunset: String
    let night: String
    
    
    
    // 생성자
    init(uid: String, dictionary: [String: Any]) {
        // uid
        self.uid = uid
        // user 정보
        self.fullName = dictionary[DBString.fullName] as? String ?? ""
        self.email = dictionary[DBString.email] as? String ?? ""
        // info(알림)
        self.noti = dictionary[DBString.noti] as? Int ?? 0
        // font_Color
        self.dawnFont = dictionary[DBString.dawnFont] as? Int ?? -1
        self.morningFont = dictionary[DBString.morningFont] as? Int ?? -2
        self.sunsetFont = dictionary[DBString.sunsetFont] as? Int ?? -3
        self.nightFont = dictionary[DBString.nightFont] as? Int ?? -4
        
        // background_Image
        self.dawn = dictionary[DBString.dawn] as? String ?? "100"
        self.morning = dictionary[DBString.morning] as? String ?? "200"
        self.sunset = dictionary[DBString.sunset] as? String ?? "300"
        self.night = dictionary[DBString.night] as? String ?? "400"
    }
    
    
    
    // 이니셜
    var firstInitial: String { return String(fullName.prefix(1))}
    
    var notiString: String {
        switch noti {
        case 0: return "OFF"
        case 1: return "ON"
        default: return "OFF"
        }
    }
}
