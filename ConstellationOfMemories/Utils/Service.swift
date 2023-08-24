//
//  Service.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/22.
//

import FirebaseCore
import FirebaseAuth
import Firebase



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
    func fetchUserData(uid: String, completion: @escaping (User) -> Void) {
        Users_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            
            let user = User(uid: uid,dictionary: dictionary)
            // completion
            completion(user)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     
    
    
    
    // MARK: - Create_Diary_Data
    func createDiaryData(uid: String, diaryText: String) {
        
        let dateFormatter = DateFormatter()
        // month
            dateFormatter.dateFormat = "M"
        let month = dateFormatter.string(from: Date())
        // day
            dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: Date())
        
        
        
        // 배열에 데이터 넣기
            // uid + diaryText + date
        let values: [String: Any] = [DBString.uid: uid,
                                     DBString.month: month,
                                     DBString.day: day,
                                     DBString.diaryText: diaryText]
        
        // Diariy_Id 만들기 (childByAutoId()를 통해서 랜덤의 Id 만들기
        let diaryId = Diary_REF.childByAutoId()
        
        // key
//        guard let diaryKey = diaryId.key else { return }
        
        // realTime_DB에 데이터를 저장
        diaryId.updateChildValues(values) { error, ref in
            if let error = error {
                print("Create Error, \(error.localizedDescription)")
                return
            } else {
                print("Create!!!!!!")
                MainVC.todayDiaryToggle = true
            }
        }
    }
    
    
    
    // MARK: - Update_Diary_Data
    func updateDiaryData(diary: Diary, diaryText: String) {
        

    }
    
    
    
    
    
    
    
    
    // MARK: - Fetch_Diary_Data
    func fetchDiaryDatas(completion: @escaping ([Diary]) -> Void) {
        var diaryDatas: [Diary] = []
        // 한 번만 completion을 하기 위해 따로 카운트
            // diary가 모두 배열에 채워지면 completion
        
        
        self.fetchDiaryData { data, num in
            diaryDatas.append(data)
            
            diaryDatas.sort { diary1, diary2 in
                return diary1.day > diary2.day
            }
            
            
            // diary가 모두 배열에 채워지면 completion
            if diaryDatas.count == num {
                completion(diaryDatas)
            }
        }
    }
    
    private func fetchDiaryData(completion: @escaping (Diary, Int) -> Void) {
        // diary 배열 생성
        var diaryArray = [String]()
        
        // diarys에 들어있는 데이터들을 가져옴
        Diary_REF.observeSingleEvent(of: .value) { snapshot in
            
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }

            allObjects.forEach { snapshot in
                // diaryId를 가져옴
                let diaryId = snapshot.key
                // 배열에 넣기
                diaryArray.append(diaryId)
                // 배열의 diaryId를 통해서 diaryId에 있는 정보들을 가져옴
                    // 이렇게 가져온 정보들은 completion.(~~~)을 통해 정보를 얻을 수 있음
                Diary_REF.child(diaryId).observeSingleEvent(of: .value) { snapshot in
                    
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    
                    guard let currentUid = dictionary[DBString.uid] as? String else { return }
                    
                    fetchUserData(uid: currentUid) { user in
                        let diary = Diary(uid: currentUid, dictionary: dictionary)
                        
                        
                        completion(diary, allObjects.count)
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
