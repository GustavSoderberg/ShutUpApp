//
//  DataManager.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-01.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import CoreData

class DataManager {
    
    let db = Firestore.firestore()
    
    func listenToFirestore() {
        
        if cm.isConnected {
            
            print("hello from firestore")
            
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
                            
                            cm.listOfConversations.append(convo!)
                            cm.refresh += 1
                            
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
                    print("## Successfully read users from firestore ##")
                    um.listOfUsers.removeAll()
                    for document in snapshot.documents {
                        let result = Result {
                            
                            try document.data(as: User.self)
                            
                        }
                        
                        switch result {
                        case.success(let user) :
                            
                            um.listOfUsers.append(user!)
                            cm.refresh += 1
                            
                        case.failure(let error) :
                            print("Error decoding convo \(error)")
                        }
                    }
                    
                    self.setCurrentUser()
                }
            }
            
        }
        else if !cm.isConnected { // COREDATA
            
            self.emptyCoredata(selection: (false,false))
            
            print("hello from core data")
            
            let fetchRequest1: NSFetchRequest<UserCOD> = UserCOD.fetchRequest()
            
            pc.perform {
                do {
                    let result = try fetchRequest1.execute()
                    print("## Successfully read users from coredata ##")
                    for user in result {
                        
                        um.listOfUsers.append(User(id: user.id!, username: user.username!, photoUrl: user.photoUrl!))
                        
                    }
                    
                    
                } catch {
                    print("E: Failed to fetch users coredata \(error)")
                }
            }
            
            let fetchRequest2: NSFetchRequest<ConversationCOD> = ConversationCOD.fetchRequest()
            
            pc.perform {
                do {
                    let result = try fetchRequest2.execute()
                    print("## Successfully read conversations from coredata ##")
                    for convo in result {
                        
                        var membersDecoded = [User]()
                        for memberCOD in convo.members! {
                            let user : UserCOD = memberCOD.self as! UserCOD
                            membersDecoded.append(User(id: user.id!, username: user.username!, photoUrl: user.photoUrl!))
                        }
                        
                        var messagesDecoded = [Message]()
                        for messageCOD in convo.messages! {
                            let message : MessageCOD = messageCOD.self as! MessageCOD
                            messagesDecoded.append(Message(id: message.id!, timeStamp: message.timeStamp!, senderID: message.senderID!, text: message.text!))
                        }
                        
                        let conversation = Conversation(uid: UUID(uuidString: convo.id!)!, name: convo.name!, members: membersDecoded, messages: messagesDecoded)
                        
                        cm.listOfConversations.append(conversation)
                        
                        
                    }
                    
                    print("Loaded \(cm.listOfConversations.count) conversations from coredata")
                    
                    self.setCurrentUser()
                    
                } catch {
                    print("E: Failed to fetch users coredata \(error)")
                }
            }
        }
    }
    
    func setCurrentUser() {
        
        if Auth.auth().currentUser != nil {
            
            for user in um.listOfUsers {
                if user.id == Auth.auth().currentUser!.uid {
                    
                    um.currentUser = user
                    print("Logged in as \(user.username)")
                    
                    cm.refresh += 1
                    
                }
                
                
            }
            
        }
        else {
            
            print("⚠️ New user detected ⚠️")
            
        }
        
        um.isLoading = false
        cm.refresh += 1
        
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
    
    func saveToCoredata(conversation: Conversation) {
        
        let convoCOD = ConversationCOD(context: pc)
        convoCOD.id = "\(conversation.uid)"
        convoCOD.name = conversation.name
        print("\(convoCOD.id) \(conversation.uid)")
        
        for member in conversation.members {
            let userCOD = UserCOD(context: pc)
            userCOD.id = member.id
            userCOD.username = member.username
            userCOD.photoUrl = member.photoUrl
            
            convoCOD.addToMembers(userCOD)
        }
        
        for message in conversation.messages {
            let messageCOD = MessageCOD(context: pc)
            messageCOD.id = message.id
            messageCOD.timeStamp = message.timeStamp
            messageCOD.senderID = message.senderID
            messageCOD.text = message.text
            
            convoCOD.addToMessages(messageCOD)
        }
        
        do {
            try pc.save()
            print("✔ Saved the conversation to coredata")
        }
        catch {
            print("E: DataManager - saveToCoreData(): Error saving conversation \(error)")
        }
        
    }
    
    func saveUserToCoredata(user: User) {
        
        let userCOD = UserCOD(context: pc)
        userCOD.id = user.id
        userCOD.username = user.username
        userCOD.photoUrl = user.photoUrl
        
        do {
            try pc.save()
            print("Saved user to coredata")
        }
        catch {
            print("E: UserManager - Register() - Failed to save new user to database\(error)")
        }
    }
    
    func updateCoredata(conversation: Conversation, message: Message) {
        
        let fetchRequest2: NSFetchRequest<ConversationCOD> = ConversationCOD.fetchRequest()
        
        pc.perform {
            do {
                let result = try fetchRequest2.execute()
                for convo in result {
                    
                    if convo.id == "\(conversation.uid)" {
                        
                        let messageCOD = MessageCOD(context: pc)
                        messageCOD.id = message.id
                        messageCOD.timeStamp = message.timeStamp
                        messageCOD.senderID = message.senderID
                        messageCOD.text = message.text
                        
                        convo.addToMessages(messageCOD)
                        
                        print("Message '\(messageCOD.text!)' updated")
                        
                    }
                    else {
                        print("Couldnt find message")
                        print("1: \(convo.id) 2:\(conversation.uid)")
                    }
                    
                }
                try! pc.save()
                
            } catch {
                print("E: Failed to fetch users coredata \(error)")
            }
        }
        
    }
    
    func deleteFromCoredata(conversation: Conversation) {
        
        let fetchRequest2: NSFetchRequest<ConversationCOD> = ConversationCOD.fetchRequest()
        
        pc.perform {
            do {
                let result = try fetchRequest2.execute()
                for convo in result {
                    
                    if convo.id == "\(conversation.uid)" {
                        
                        pc.delete(convo)
                        print("⚠ Deleted conversation from coredata")
                        
                    }
                    
                    else {
                        print("Couldnt find conversation to remove from coredata")
                    }
                    
                }
                try! pc.save()
                
            } catch {
                print("E: Failed to fetch users coredata \(error)")
            }
        }
        
    }
    
    func emptyCoredata(selection: (Bool,Bool)) { // selection.0 for users, selection.1 for conversations
        
        if selection.0 {
            
            let fetchRequest1: NSFetchRequest<UserCOD> = UserCOD.fetchRequest()
            
            pc.perform {
                do {
                    let result = try fetchRequest1.execute()
                    print("## Successfully read users from coredata ##")
                    for user in result {
                        
                        pc.delete(user)
                        
                    }
                    
                    try! pc.save()
                    
                    print("Coredata users is now empty")
                    
                } catch {
                    print("E: Failed to fetch users coredata \(error)")
                }
            }
            
        }
        
        if selection.1 {
            
            let fetchRequest2: NSFetchRequest<ConversationCOD> = ConversationCOD.fetchRequest()
            
            pc.perform {
                do {
                    let result = try fetchRequest2.execute()
                    print("## Successfully read conversations from coredata ##")
                    for convo in result {
                        
                        pc.delete(convo)
                        
                    }
                    
                    try! pc.save()
                    
                    print("Coredata conversations is now empty")
                    
                } catch {
                    print("E: Failed to remove conversations coredata \(error)")
                }
            }
            
        }
        
    }
    
}
