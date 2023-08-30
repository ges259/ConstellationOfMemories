//
//  DBString.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/07.
//

import FirebaseDatabase

struct DBString {
    
    // MARK: - User
    static let fullName: String = "fullName"
    static let email: String = "email"
    static let password: String = "password"
        
    static let fontColor: String = "fontColor"
//    static let backgroundURL: String = "backgroundURL"
    
    // 알림 설정
    static let noti: String = "noti"
    //
//    static let lastDiary: String = "lastDiary"
    
    // Background_Image
    static let dawn: String = "dawn"
    static let morning: String = "morning"
    static let sunset: String = "sunset"
    static let night: String = "night"
    
    
    
    // MARK: - Diary
    static let uid: String = "userId"
    static let month: String = "month"
    static let day: String = "day"
    static let diaryText: String = "diaryText"
}



let DB_REF: DatabaseReference = Database.database().reference()

// user
let Users_REF: DatabaseReference = DB_REF.child("users")
let Diary_REF: DatabaseReference = DB_REF.child("diarys")
let Image_REF: DatabaseReference = DB_REF.child("background")




