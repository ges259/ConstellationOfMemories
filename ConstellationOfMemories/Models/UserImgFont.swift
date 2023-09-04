//
//  UserImgFont.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/09/04.
//

struct UserImgFont {
    let dawnFont: Int
    let dawnImg: String
    
    let morningFont: Int
    let morningImg: String
    
    let sunsetFont: Int
    let sunsetImg: String
    
    let nightFont: Int
    let nightImg: String
    
    init(dictionary: [String: Any]) {
        // Font_Color
        self.dawnFont = dictionary[DBString.dawnFont] as? Int ?? -1
        self.morningFont = dictionary[DBString.morningFont] as? Int ?? -2
        self.sunsetFont = dictionary[DBString.sunsetFont] as? Int ?? -3
        self.nightFont = dictionary[DBString.nightFont] as? Int ?? -4
        
        // Image
        self.dawnImg = dictionary[DBString.dawnImg] as? String ?? "100"
        self.morningImg = dictionary[DBString.morningImg] as? String ?? "200"
        self.sunsetImg = dictionary[DBString.sunsetImg] as? String ?? "300"
        self.nightImg = dictionary[DBString.nightImg] as? String ?? "400"
    }
}
