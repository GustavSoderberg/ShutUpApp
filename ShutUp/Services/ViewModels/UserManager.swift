//
//  UserManager.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-12.
//

import Foundation
import CoreData

class UserManager {
    
    
    
    var currentUser: User? = nil
    var listOfUsers = [User]()
    var isLoading = true
    
    func register(username: String, uid: String, photoUrl: String) {
        
        let user = User(id: uid, username: username, photoUrl: photoUrl)
        
        dm.saveUserToCoredata(user: user)
        dm.saveUserToFirestore(user: user)
        self.currentUser = User(id: uid, username: username, photoUrl: photoUrl)
        
    }
    
    func loginCheck(uid: String, firstTime: Bool) -> Bool {
        
        
        for user in listOfUsers {
            
            if user.id == uid {
                
                self.currentUser = user
                if firstTime { dm.saveUserToCoredata(user: user) }
                print("Logged in as \(user.username)")
                return false
                
            }
        }
        
        return true
        
    }
}
