/**
 
 - Description:
 The UserManager.swift is a ViewModel for the registration and logging in of a user
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

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
    
    /**
     Since we want to match the logged in user from Firebase auth with the user object in our firestore we loop through them and sets the current user when the uid matches
     */
    
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
