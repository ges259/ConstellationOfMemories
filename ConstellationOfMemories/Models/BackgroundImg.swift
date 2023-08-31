//
//  BackgroundImg.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/30.
//

struct BackgroundImg {
    
    // MARK: - Properties
    // dawn
    var havedawn: [Int]
    // morning
    var haveMorning: [Int]
    // sunset
    var haveSunset: [Int]
    // night
    var haveNight: [Int]
    
    // total_Image_count
    var totalImgCount = 0
    
    
    
    // MARK: - Init
    init(dictionary: [Int]) {
        // 기본 초기화
        self.havedawn = []
        self.haveMorning = []
        self.haveSunset = []
        self.haveNight = []
        
        // 반복문
        for _ in 0 ..< dictionary.count {
            // dawn
            if dictionary[self.totalImgCount] < 200 {
                self.havedawn.append(dictionary[self.totalImgCount])
                
                
            // morning
            } else if dictionary[self.totalImgCount] < 300 {
                self.haveMorning.append(dictionary[self.totalImgCount])
                
                
            // sunset
            } else if dictionary[self.totalImgCount] < 400 {
                self.haveSunset.append(dictionary[self.totalImgCount])
                
                
            // night
            } else {
                self.haveNight.append(dictionary[self.totalImgCount])
            }
            self.totalImgCount += 1
        }
    }
    
    
    
    
    
    
    
    // MARK: - Dont_Have_Image
    // 사용자가 가지고 있지 않은 이미지
    func dontHaveDawnImg() -> [Int] {
        // 모든 이미지
        var dawn: [Int] = [100, 101, 102] // dawn
        var morning: [Int] = [200, 201, 202] // morning
        var sunset: [Int] = [300, 301, 302] // sunset
        var night: [Int] = [400, 401, 402] // night
        
        
        // 가지고 있지 않은 이미지
        var totalDontHave = [Int]()
        
        
        // 가지고 있는 이미지
        let have: [Int] = self.havedawn // dawn
                        + self.haveMorning // morning
                        + self.haveSunset // sunset
                        + self.haveNight // night
        
        
        // have의 개수
            // 0부터 시작하면 인덱스 버그 발생
        var count = have.count - 1
        
        
        // have에 있는 이미지 삭제
        for _ in 0 ..< have.count {
            if have[count] < 200 {
                dawn = self.removeHaveImg(array: dawn, targetNum: have[count] - 100)
                
            } else if have[count] < 300 {
                morning = self.removeHaveImg(array: morning, targetNum: have[count] - 200)
                
            } else if have[count] < 400 {
                sunset = self.removeHaveImg(array: sunset, targetNum: have[count] - 300)
                
            } else {
                night = self.removeHaveImg(array: night, targetNum: have[count] - 400)
            }
            
            count -= 1
        }
        
        totalDontHave = dawn + morning + sunset + night
        
        
        // 가지고 있지 않은 이미지(Int값으로) 반환
        return totalDontHave
    }
    
    private func removeHaveImg(array: [Int], targetNum: Int) -> [Int] {
        var haveArray = array
            haveArray.remove(at: targetNum)
        return haveArray
    }
}



//        switch currentTime {
//        case .dawn:
//            dontHave = [100, 101, 102]
//            have = backImg.havedawn
//
//        case .morning:
//            dontHave = [200, 201, 202]
//            have = backImg.haveMorning
//
//        case .sunset:
//            dontHave = [300, 301, 302]
//            have = backImg.haveSunset
//        case .night:
//            dontHave = [400, 401, 402]
//            have = backImg.haveNight
//        }


