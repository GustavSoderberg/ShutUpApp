/**
 
 - Description:
 The DataManager.swift handles the communication with Firestore and/or Core Data depending on the users internet connection
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import Foundation
import Firebase
import FirebaseFirestoreSwift
import CoreData

class DataManager {
    
    let db = Firestore.firestore()
    
    func listenToFirestore() {
        
        if cm.isConnected {
            
            self.wipeCoredata(selection: (false, false))
            
            db.collection("convos").addSnapshotListener { snapshot, err in
                
                guard let snapshot = snapshot else { return }
                
                if let err = err {
                    print("Error getting convo document \(err)")
                    
                } else {
                    cm.listOfConversations.removeAll()
                    print("## Successfully read convos from firestore ##")
                    
                    for document in snapshot.documents {
                        let result = Result {
                            
                            try document.data(as: Conversation.self)
                            
                        }
                        
                        switch result {
                        case.success(let convo) :
                            
                            self.saveToCoredata(conversation: convo!)
                            
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
        else if !cm.isConnected {
            
            self.wipeCoredata(selection: (false,false))
            
            let fetchRequest1: NSFetchRequest<UserCOD> = UserCOD.fetchRequest()
            
            pc.perform {
                do {
                    
                    let result = try fetchRequest1.execute()
                    for user in result {
                        
                        um.listOfUsers.append(User(id: user.id!, username: user.username!, photoUrl: user.photoUrl!))
                        
                    }
                    
                    print("## Successfully read users from coredata ##")
                    
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
                        
                        let conversation = Conversation(uid: UUID(uuidString: convo.uid!)!, name: convo.name!, members: membersDecoded, messages: messagesDecoded)
                        
                        cm.listOfConversations.append(conversation)
                        
                        
                    }
                    
                    print("Loaded \(cm.listOfConversations.count) conversation(s) from coredata")
                    
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
                    break
                    
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
        
            
            var existingConversation = false
            let fetchRequest2: NSFetchRequest<ConversationCOD> = ConversationCOD.fetchRequest()
            
            pc.perform {
                do {
                    let result = try fetchRequest2.execute()
                    
                    for convo in result {
                        
                        
                        if convo.uid! == "\(conversation.uid)" && convo.messages!.count < conversation.messages.count {
                            let messageCOD = MessageCOD(context: pc)
                            messageCOD.id = conversation.messages.last!.id
                            messageCOD.timeStamp = conversation.messages.last!.timeStamp
                            messageCOD.senderID = conversation.messages.last!.senderID
                            messageCOD.text = conversation.messages.last!.text
                            
                            convo.addToMessages(messageCOD)
                            
                            do {
                                try pc.save()
                                existingConversation = true
                                print("Message updated to the existing coredata conversation")
                            }
                            catch {
                                print(error)
                            }
                            break
                            
                        } else if convo.uid! == "\(conversation.uid)"  {
                            
                            existingConversation = true
                            
                        }
                        
                    }
                    
                    
                    if !existingConversation {

                        let convoCOD = ConversationCOD(context: pc)
                        convoCOD.uid = "\(conversation.uid)"
                        convoCOD.name = conversation.name

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
                            print("✔ A conversation was saved to coredata")
                        }
                        catch {
                            print("E: DataManager - saveToCoreData(): Error saving conversation \(error)")
                        }

                    }
                    
                } catch {
                    print("E: Failed to fetch users coredata \(error)")
                }
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
                    
                    if convo.uid == "\(conversation.uid)" {
                        
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
                    
                    if convo.uid == "\(conversation.uid)" {
                        
                        pc.delete(convo)
                        print("⚠ Deleted conversation from coredata")
                        cm.refresh += 1
                        
                    }
                    
                }
                try! pc.save()
                
            } catch {
                print("E: Failed to delete conversation from coredata \(error)")
            }
        }
        
    }
    
    func wipeCoredata(selection: (Bool,Bool)) {
        
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
                    for convo in result {
                        
                        pc.delete(convo)
                        
                    }
                    
                    try! pc.save()
                    
                    print("## Successfully deleted all conversations from coredata ##")
                    
                } catch {
                    print("E: Failed to remove conversations coredata \(error)")
                }
            }
            
        }
        
    }
    
}
