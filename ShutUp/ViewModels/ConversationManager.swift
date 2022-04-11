//
//  ConversationModel.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ConversationManager: ObservableObject {
    
    var currentUser: User? = nil
    var listOfUsers = [User]()
    var selectedUsers = [User]()
    @Published var listOfConversations = [Conversation]()
    @Published var refresh = 0
    var index = 0
    
    init() {
        
        listOfUsers.append(User(id: "tempId1", name: "Andreas", username: "test1", password: "test1"))
        listOfUsers.append(User(id: "tempId2", name: "Calle", username: "test2", password: "test2"))
        listOfUsers.append(User(id: "tempId3", name: "Gustav", username: "test3", password: "test3"))

    }
    
    func login() -> Bool {
        
        if let uid = auth.currentUser?.uid {
            self.currentUser = User(id: uid, name: "you", username: "you", password: "i'm you")
            return true
        }
        else {
            return false
        }
        
    }
    
    func newConversation(name: String) {
        
        selectedUsers.append(currentUser!)
        let conversation = Conversation(name: name, members: selectedUsers)
        selectedUsers.removeAll()
        
        dm.saveToFirestore(convo: conversation)
        self.listOfConversations.append(conversation)
        
    }
    
    func sendMessage(message: String, user: User, conversation: Conversation) {
        
        let newMessage = Message(timeStamp: Date.now, senderID: user.id, text: message)
        conversation.messages.append(newMessage)
        dm.updateFirestore(conversation: conversation, message: newMessage)
        
    }
    
    func updateConversation(id: Conversation.ID) -> Conversation? {
        
        for conversation in listOfConversations {
            
            if conversation.id == id {
                return conversation
                refresh += 1
            }
            
        }
        
        return nil
        
    }
    
    func select(user: User) {
        self.selectedUsers.append(user)
        self.refresh += 1
    }
    
    func unselect(userToRemove: User) {
        
        for index in 0...selectedUsers.count-1 {
            if userToRemove == selectedUsers[index] {
                self.selectedUsers.remove(at: index)
                self.refresh += 1
                break
            }
        }
    }
}
