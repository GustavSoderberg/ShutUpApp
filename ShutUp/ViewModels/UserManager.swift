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
    
    func loginCheck(uid: String) -> Bool {
        
        
        for user in listOfUsers {
            
            if user.id == uid {
                
                self.currentUser = user
                print("Logged in as \(user.username)")
                return false
                
            }
        }
        
        
        return true
        
        
    }
    
    func loginCoredata(uid: String) {
        
        for user in listOfUsers {
            
            if user.id == uid {
                
                print("Oh Coredata plz log me in it's my first time")
                let user = User(id: user.id, username: user.username, photoUrl: user.photoUrl)
                dm.saveUserToCoredata(user: user)
                
            }
        }
        
    }
}
