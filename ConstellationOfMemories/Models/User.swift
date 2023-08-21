//
//  User.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/21.
//

struct User {
    let uid: String
    let fullName: String
    let email: String
    
    
    
    let fontColor: String
    // String으로?
    let backgroundUrl: String
    // 알림 설정
    let notification: Bool = false
    // 이니셜
    var firstInitial: String { return String(fullName.prefix(1))}
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        
        self.fullName = dictionary[DBString.fullName] as? String ?? ""
        self.email = dictionary[DBString.email] as? String ?? ""
        
        self.fontColor = dictionary[DBString.fontColor] as? String ?? ""
        self.backgroundUrl = dictionary[DBString.backgroundColor] as? String ?? ""
    }
}
