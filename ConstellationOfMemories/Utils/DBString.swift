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
    static let backgroundColor: String = "backgroundColor"
    
    static let notification: String = "notification"
    
    
    
    // MARK: - Diary
    static let date: String = "date"
    static let diaryText: String = "diaryText"
//    static let like: String = "like"
}



let DB_REF: DatabaseReference = Database.database().reference()

// user
let REF_USERS: DatabaseReference = DB_REF.child("users")





