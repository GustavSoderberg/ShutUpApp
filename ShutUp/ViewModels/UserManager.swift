//
//  UserManager.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-12.
//

import Foundation

class UserManager {
    
    var currentUser: User? = nil
    var listOfUsers = [User]()
    
    func register(username: String, uid: String, photoUrl: String) {
        
        if !loginCheck(uid: uid) {
            
            self.currentUser = User(id: uid, username: username, photoUrl: photoUrl)
            
        }
        
        else {
            
            dm.saveUserToFirestore(user: User(id: uid, username: username, photoUrl: photoUrl))
            self.currentUser = User(id: uid, username: username, photoUrl: photoUrl)
            
        }

    }

    
    func loginCheck(uid: String) -> Bool {
        
        for user in listOfUsers {
            
            if user.id == uid {
                print("Logged in as existing user")
                return false
            }
        }
        
        print("⚠️ New user detected ⚠️")
        return true
    }

    
}
