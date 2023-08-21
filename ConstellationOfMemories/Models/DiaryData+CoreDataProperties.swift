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
//    var dateString: String? {
        // 싱글톤
//        let coreDateManager = CoreDataManager.shared
//
//        // 코어데이터에 저장된 날짜를 가져옴
//        guard let date: Date = self.date else { return "" }
//
//        // 가져온 날짜 데이터를 String으로 변환
//        let dateString = coreDateManager.configureDate(date: date)
//        return dateString
//    }
//
    
    
    
    
    
    
    
    
    
    
    
//    var todayString: String? {
//        let todatyString: String = self.configureData(format: "")
//
//        return todatyString
//    }
    
    
    
    
    
}

extension DiaryData : Identifiable {

}
