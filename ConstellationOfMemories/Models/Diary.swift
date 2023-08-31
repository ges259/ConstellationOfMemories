//
//  Diary.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/21.
//

import Foundation

struct Diary {
    // 일기 작성 날짜
    let month: String
    let day: String
    
    // 일기 작성 내용
    let diaryText: String
    
    init(month: String, day: String, dictionary: [String: Any]) {
        self.month = month
        self.day = day
        
        self.diaryText = dictionary[DBString.diaryText] as? String ?? ""
    }
}
