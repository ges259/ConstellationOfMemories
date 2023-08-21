//
//  CoreDataManager.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/13.
//

import UIKit
import CoreData

final class CoreDataManager {
    // 코어데이터에 접근하기 위한 싱글톤 생성
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트에 접근하기 위한 변수 생성
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소 (context)
        // crud를 하기 위해서 임시저자에소에 접근해야 함
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "DiaryData"
    
    
    
    
    
    
    // MARK: - [Time]
    private func configureFormate(date: Date, format: String) -> String {
        let myformatter = DateFormatter()
            myformatter.dateFormat = format
        
        let date: Date = date
        
        let savedDateString: String = myformatter.string(from: date)
        return savedDateString
    }
    
    
    func configureDate(date: Date) -> String {
//        guard let date = diaryData.date else { return "" }
        
        let dateString: String = self.configureFormate(date: date, format: "M월 d일에")
        
        return dateString
    }
    
    
    
    func configureTodayDiaryToggle(diaryData: DiaryData) {
        // 오늘 며칠인 지 확인
        let currentTime = Date()
        let currentData: String = self.configureDate(date: currentTime)
        
        // 오늘 일기를 작성했는지 안 했는지 확인
        DiaryTableView.todayDiaryToggle = diaryData.dateString == currentData
        ? true
        : false
    }
    
    
    
    
    
    // MARK: - [Read]
        // 코어데이터에 저장된 데이터 모두 읽어오기
    func readDiaryDatas() -> [DiaryData] {
        var diaryDatas = [DiaryData]()
        
        // 임시저장소가 있는지 확인
        if let context = self.context {
            // 요청서 만들기
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 데이터들의 정렬 방법 설정
                // 날짜순으로 정렬
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            // 정렬순서를 요청서에 넘겨주기
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시 저장소에 접근
                    // 앞에서 생성한 요청서를 통해 데이터를 가져옴
                if let fetchedDiaryData = try context.fetch(request) as? [DiaryData] {
                    diaryDatas = fetchedDiaryData
                }
            } catch {
                print("데이터 가져오기 실패")
            }
        }
        return diaryDatas
    }
    
    
    
    
    
    
    
    
    
    
    /*
     context.perform() 을 통해 비동기 처리를 할 수 있음
     */
    // MARK: - [Create]
        // 코어데이터에 데이터 생성하기
    func createDiaryData(diaryText: String?) {
        // 임시저장소가 있는지 확인
        if let context = self.context {
            
            // 임시저장소에 있는 데이터를 그려줄 형태를 파악.
            // DiaryData의 형태로 context에 저장
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName,
                                                       in: context) {
                
                // 임시저장소에 올라가게 할 객체 만들기 (NSManagedObject --->>> DiaryData)
                // 이렇게도 사용할 수 있음
                // -> let diaryData = DiaryData(context: context)
                if let diaryData = NSManagedObject(entity: entity, insertInto: context) as? DiaryData {
                    
                    // ***** DiaryData에 데이터들을 넣음
                    diaryData.diaryText = diaryText
                    diaryData.date = Date() // 날짜는 생성한 시간을 넣음
                    
                    // context에 변화가 있다면 데이터 저장
                    self.appDelegate?.saveContext()
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - [Delete]
    // 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 --->>> 삭제)
    func deleteDiaryData(data: DiaryData, completion: @escaping () -> Void) {
        // DiaryData를 없애는 기준이 될 date 옵셔널바인딩
        guard let date = data.date else {
            completion()
            return
        }
        
        // 임시저장소가 있는지 확인
        if let context = self.context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                    // 날짜를 통해서 데이터를 가져오기 때문에 1개의 데이터만 가져옴
                if let fetchedDiaryData = try context.fetch(request) as? [DiaryData] {
                    // 임시저장소에서 (요청서를 통해) 데이터 삭제하기 (delete 메서드)
                        // 데이터가 1개 밖에 없기 때문에 .first를 사용하여 삭제
                    if let targetDiaryData = fetchedDiaryData.first {
                        context.delete(targetDiaryData)
                    }
                    // context에 변화가 있다면 데이터 삭제
                    self.appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("지우기 실패")
                completion()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - [Update]
    // , completion: @escaping () -> Void
    func updateDiaryData(newDiaryData: DiaryData) {
        // DiaryData를 없애는 기준이 될 date 옵셔널바인딩
        guard let date = newDiaryData.date else { return }
        
        // 임시저장소가 있는지 확인
        if let context = self.context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                    // 날짜를 통해서 데이터를 가져오기 때문에 1개의 데이터만 가져옴
                if let fetchedDiaryData = try context.fetch(request) as? [DiaryData] {
                    // 임시저장소에서 (요청서를 통해) 데이터 업데이트
                        // 데이터가 1개 밖에 없기 때문에 .first를 사용하여 업데이트
                    if var targetDiaryData = fetchedDiaryData.first {
                        
                        // ***** diaryData에 실제 데이터 재할당 *****
                        targetDiaryData = newDiaryData
                        
                        // context에 변화가 있다면 데이터 삭제
                        self.appDelegate?.saveContext()
                    }
                }
            } catch {
                print("지우기 실패")
            }
        }
    }
}
