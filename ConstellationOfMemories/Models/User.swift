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
    let dawnImg: String
    let morningImg: String
    let sunsetImg: String
    let nightImg: String
    
    
    
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
        self.dawnImg = dictionary[DBString.dawnImg] as? String ?? "100"
        self.morningImg = dictionary[DBString.morningImg] as? String ?? "200"
        self.sunsetImg = dictionary[DBString.sunsetImg] as? String ?? "300"
        self.nightImg = dictionary[DBString.nightImg] as? String ?? "400"
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
