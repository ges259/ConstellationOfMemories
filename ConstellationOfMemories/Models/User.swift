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
    
    
    // 글자 색상
    let fontColor: Int = 1
    // 배경 화면
    let backgroundUrl: Int = 101
    
    
    // 알림 설정
    let noti: Bool
    // 일기 작성 날짜
    let lastDiary: Bool
    
    
    // 생성자
    init(uid: String, dictionary: [String: Any]) {
        // uid
        self.uid = uid
        // user 정보
        self.fullName = dictionary[DBString.fullName] as? String ?? ""
        self.email = dictionary[DBString.email] as? String ?? ""
        
        
        // info는 자동 생성 되도록
        self.noti = false
        self.lastDiary = false
    }
    
    
    // 이니셜
    var firstInitial: String { return String(fullName.prefix(1))}
}
