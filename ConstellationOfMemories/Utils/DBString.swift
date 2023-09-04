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
    static let noti: String = "noti"
    static let coin: String = "coin"
    
    
    
    
    // MARK: - User_Img_Font
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
    static let month: String = "month"
    static let day: String = "day"
    static let diaryText: String = "diaryText"
}






// MARK: - DB
let DB_REF: DatabaseReference = Database.database().reference()

let Users_REF: DatabaseReference = DB_REF.child("users")
let Diary_REF: DatabaseReference = DB_REF.child("diarys")
let Image_REF: DatabaseReference = DB_REF.child("haveImg")
let imgFont_REF: DatabaseReference = DB_REF.child("current-ImgFont")




