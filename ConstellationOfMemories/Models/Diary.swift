//
//  Diary.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/21.
//

import Foundation

struct Diary {
    // user
//    let user: User
    
    // uid
    let uid: String
    // 일기 작성 날짜
//    let date: String
    let month: String
    let day: String
    
    
    // 일기 작성 내용
    let diaryText: String
    
//    let like: Int
    
    init(uid: String, dictionary: [String: Any]) {
        // user
//        self.user = user
        
        // uid
        self.uid = uid
            
        self.month = dictionary[DBString.month] as? String ?? ""
        self.day = dictionary[DBString.day] as? String ?? ""
        
        self.diaryText = dictionary[DBString.diaryText] as? String ?? ""
    }
}
