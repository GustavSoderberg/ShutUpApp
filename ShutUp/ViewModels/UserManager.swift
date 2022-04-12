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
    
    func login(username: String) -> Bool {
        
        if let uid = auth.currentUser?.uid {
            
            dm.saveUserToFirestore(user: User(id: uid, username: username))
            self.currentUser = User(id: uid, username: username)
            return true
        }
        else {
            return false
        }
        
    }
    
    func loginCheck(uid: String) -> Bool {
        
        for user in listOfUsers {
            
            if user.id == uid {
                self.currentUser = user
                print("Logged in as \(currentUser!.username)")
                return false
            }
        }
        
        print("⚠️ New user detected ⚠️")
        return true
    }

    
}
