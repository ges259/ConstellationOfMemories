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
    let date: String
    // 일기 작성 내용
    let diaryText: String
    
//    let like: Int
    
    init(uid: String, dictionary: [String: Any]) {
        // user
//        self.user = user
        
        // uid
        self.uid = uid
            
        self.date = dictionary[DBString.date] as? String ?? ""
        
        self.diaryText = dictionary[DBString.diaryText] as? String ?? ""
    }
}
