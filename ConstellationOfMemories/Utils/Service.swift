//
//  Service.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/22.
//

import FirebaseCore
import FirebaseAuth



struct Service {
    static let shared = Service()
    init() {}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func fetchUserData(uid: String,completion: @escaping (User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let uid = snapshot.key
            
            let user = User(uid: uid,dictionary: dictionary)
            // completion
            completion(user)
        }
    }
    
}
