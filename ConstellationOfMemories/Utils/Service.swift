//
//  Service.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/22.
//

import FirebaseCore
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

import UIKit

struct Service {
    static let shared = Service()
    init() {}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Frailed to register user with error \(error.localizedDescription)")
                return
            }
            completion()
        }
    }
    
    // MARK: - SignUp
    func signUp(fullName: String, email: String, password: String, completion: @escaping () -> Void) {
        print(#function)
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Frailed to register user with error \(error.localizedDescription)")
                return
            }
            // uid 가져오기
            guard let uid = result?.user.uid else { return }
            // user정보 만들기
            let values = [DBString.fullName: fullName,
                          DBString.email: email,
                          DBString.password: password] as [String: Any]
            
            // Create_User_Data
                // user정보를 uid를 통해 DB에 저장
            Users_REF.child(uid).updateChildValues(values) { error, ref in
                completion()
            }
        }
    }
    
    
    
    // MARK: - Fetch_User_Data
    func fetchUserData(completion: @escaping (User) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Users_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            
            let user = User(uid: uid,dictionary: dictionary)
            // completion
            completion(user)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Update_Background
    func backgroundBackground(num: Int, completion: @escaping () -> Void) {
        // uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // create_Dictionary_____background_number
        let value: [String: Int] = ["\(num)": 0]
        // create_Background
        Image_REF.child(uid).updateChildValues(value)
        // completion
        completion()
    }
    
    
    
    // MARK: - Fetch_Background
    func fetchBackground(completion: @escaping (BackgroundImg) -> Void) {
        // uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // return Array
        var numArray: [Int] = []
        
        // fetch_Background
        Image_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            // background_number를 배열로 만들기
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            allObjects.forEach { snapshot in
                guard let ddd = Int(snapshot.key) else { return }
                numArray.append(ddd)
            }
            
            let imageArray = BackgroundImg(dictionary: numArray)
            
            completion(imageArray)
        }
    }
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Create_Diary_Data
    func createDiaryData(diaryText: String) {
        // Date
        let dateFormatter = DateFormatter()
            // month
            dateFormatter.dateFormat = "M"
        let month = dateFormatter.string(from: Date())
            // day
            dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: Date())
        
        // uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        // 배열에 데이터 넣기
            // uid + diaryText + date
        let value: [String: Any] = [DBString.month: month,
                                     DBString.day: day,
                                     DBString.diaryText: diaryText]
        
        
        // Diariy_Id 만들기 (childByAutoId()를 통해서 랜덤의 Id 만들기
//        let diaryId = Diary_REF.child(uid).childByAutoId()
        let diaryId = Diary_REF.child(uid).child("\(month)\(day)")

        
        
        // realTime_DB에 데이터를 저장
        diaryId.updateChildValues(value) { error, ref in
            if let error = error {
                print("***** Create Error *****, \(error.localizedDescription)")
                return
            } else {
                print("Create!!!!!!")
                MainVC.todayDiaryToggle = true
            }
        }
    }
    
    
    
    // MARK: - Update_Diary_Data
    func updateDiaryData(diary: Diary, diaryText: String) {
        print("Update!!!!!")
        // uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // update_Diary
        Diary_REF.child(uid).child("\(diary.month)\(diary.day)").child(DBString.diaryText).setValue(diaryText)
    }
    
    
    
    // MARK: - Fetch_Diary_Data
    func fetchDiaryDatas(completion: @escaping ([Diary]?) -> Void) {
        var diaryDatas: [Diary] = []
        
        self.fetchDiaryData { data, num in
            // 데이터가 없다면 nil 반환(completion)
            guard let data = data else {
                completion(nil)
                return
            }
            
            // diaryDatas - 데이터 추가
            diaryDatas.append(data)
            
            // diaryDatas - 배열 정렬
            diaryDatas.sort { diary1, diary2 in return diary1.day > diary2.day }
            
            // 한 번만 completion을 하기 위해 따로 카운트
                // diary가 모두 배열에 채워지면 completion
            if diaryDatas.count == num {
                completion(diaryDatas)
                return
            }
        }
    }
    
    private func fetchDiaryData(completion: @escaping (Diary?, Int) -> Void) {
        // diary 배열 생성
        var diaryArray = [String]()
        // uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // diarys에 들어있는 데이터들을 가져옴
        Diary_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            // Diary의 uid
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            // 데이터가 없다면 nil 반환(completion)
            if allObjects.count == 0 { completion(nil, 0) }

            // 데이터 가져오기
            allObjects.forEach { snapshot in
                // diaryId를 가져옴
                let diaryId = snapshot.key
                // 배열에 넣기
                diaryArray.append(diaryId)

                // 배열의 diaryId를 통해서 diaryId에 있는 정보들을 가져옴
                    // 이렇게 가져온 정보들은 completion.(~~~)을 통해 정보를 얻을 수 있음
                Diary_REF.child(uid).child(diaryId).observeSingleEvent(of: .value) { snapshot in
                    // dictionary 값으로 만들기
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    // Diary 객체 생성
                    let diary = Diary(diaryId: diaryId,uid: uid, dictionary: dictionary)
                    // completion()
                    completion(diary, allObjects.count)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Info
    func fetchInfo(on: Bool) {
        // uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // 알람 켜기
        if on == true {
            Users_REF.child(uid).child(DBString.noti).setValue(1)
        // 알람 끄기
        } else {
            Users_REF.child(uid).child(DBString.noti).setValue(0)
        }
    }
}
