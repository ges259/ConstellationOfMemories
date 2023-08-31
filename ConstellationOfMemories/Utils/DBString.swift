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
        
    

    
    // 알림 설정
    static let noti: String = "noti"
    
    // Font
    static let dawnFont: String = "dawnFont"
    static let morningFont: String = "morningFont"
    static let sunsetFont: String = "sunsetFont"
    static let nightFont: String = "nightFont"
    
    
    // Background_Image
    static let dawnImg: String = "dawnImg"
    static let morningImg: String = "morningImg"
    static let sunsetImg: String = "sunsetImg"
    static let nightImg: String = "nightImg"
    
    
    
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




