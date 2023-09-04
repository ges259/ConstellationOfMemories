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
    // 코인
    let coin: Int
    
    
    
    // 생성자
    init(uid: String, dictionary: [String: Any]) {
        // uid
        self.uid = uid
        // user 정보
        self.fullName = dictionary[DBString.fullName] as? String ?? ""
        self.email = dictionary[DBString.email] as? String ?? ""
        // info(알림)
        self.noti = dictionary[DBString.noti] as? Int ?? 0
        self.coin = dictionary[DBString.coin] as? Int ?? 0
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
