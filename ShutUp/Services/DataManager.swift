//
//  DataManager.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-01.
//

import Foundation
import Firebase

class DataManager {
    
    let db = Firestore.firestore()
    
    func listenToFirestore() {
        
        db.collection("convos").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else { return }
            
            if let err = err {
                print("Error getting convo document \(err)")
                
            } else {
                cm.listOfConversations.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        
                        try document.data(as: Conversation.self)
                        
                    }
                    
                    switch result {
                    case.success(let convo) :
                        
                        cm.listOfConversations.append(convo)
                        cm.refresh += 1
                        print(cm.refresh)
                        
                    case.failure(let error) :
                        print("Error decoding user \(error)")
                    }
                }
            }
        }
        
        db.collection("users").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else { return }
            
            if let err = err {
                print("Error getting user document \(err)")
                
            } else {
                um.listOfUsers.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        
                        try document.data(as: User.self)
                        
                    }
                    
                    switch result {
                    case.success(let user) :
                        
                        um.listOfUsers.append(user)
                        print(um.listOfUsers.count)
                        cm.refresh += 1
                        
                    case.failure(let error) :
                        print("Error decoding convo \(error)")
                    }
                }
            }
        }
    }
    
    func saveToFirestore(convo: Conversation) {
        
        do {
            _ = try db.collection("convos").addDocument(from: convo)
        } catch {
            print("Error saving to db")
        }
    }
    
    func saveUserToFirestore(user: User) {
        
        do {
            _ = try db.collection("users").addDocument(from: user)
        } catch {
            print("Error saving to db")
        }
    }
    
    
    func updateFirestore(conversation: Conversation, message: Message) {
        
        //Code to get auth UID : guard let uid = auth.currentUser?.uid else { return }
        //let xSender = ["id" : "\(uid)", TODO: Switch to UID when registration/listOfUsers + authentication is live
        
        let xMessage = ["id" : "\(message.id)",
                        "senderID" : message.senderID,
                        "text" : message.text,
                        "timeStamp" : message.timeStamp] as [String : Any]
        
        if let id = conversation.id {
            db.collection("convos").document(id)
        
                .updateData([
                    "messages": FieldValue.arrayUnion([xMessage])
                    
                ])
            
        }
        
    }
    
    func deleteFromFirestore(conversation: Conversation) {
        
        if let id = conversation.id {
            db.collection("convos").document(id).delete()
        }
        
    }
}
