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
        
        dm.saveUserToFirestore(user: User(id: uid, username: username, photoUrl: photoUrl))
        self.currentUser = User(id: uid, username: username, photoUrl: photoUrl)
        
        let userCD = UserCD(context: pc)
        userCD.id = uid
        userCD.username = username
        try! pc.save()
        
    }
    
    func loginCheck(uid: String) -> Bool {
        
        
        for user in listOfUsers {
            
            if user.id == uid {
                
                let userCD = UserCD(context: pc)
                userCD.id = user.id
                userCD.username = user.username
                try! pc.save()
                
                self.currentUser = user
                print("Logged in as \(user.username)")
                return false
            }
        }
        
        
        return true
        
        
    }
}
