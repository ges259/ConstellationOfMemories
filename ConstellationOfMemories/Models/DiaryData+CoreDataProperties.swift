//
//  DiaryData+CoreDataProperties.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/13.
//
//

import Foundation
import CoreData


extension DiaryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryData> {
        return NSFetchRequest<DiaryData>(entityName: "DiaryData")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var diaryText: String?
    @NSManaged public var fontColor: Int64
    @NSManaged public var fontSize: Int16
    
    
    // date 설정
    var dateString: String? {
        let myformatter = DateFormatter()
        myformatter.dateFormat = "M월 d일에"
        
        guard let date = self.date else { return "" }
        let savedDateString = myformatter.string(from: date)
        
        return savedDateString
    }

}

extension DiaryData : Identifiable {

}
