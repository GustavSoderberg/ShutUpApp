//
//  ConversationModel.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

class ConversationManager: ObservableObject {
    
    let currentUser: User
    var listOfUsers = [User]()
    var selectedUsers = [User]()
    @Published var listOfConversations = [Conversation]()
    @Published var refresh = 0
    
    init(uid: String) {
        
        self.currentUser = User(id: uid, name: "you", username: "gustav", password: "123")
        listOfUsers.append(User(id: "tempId2", name: "Andreas", username: "test", password: "test"))
        listOfUsers.append(User(id: "tempId3", name: "Calle", username: "test", password: "test"))
        listOfUsers.append(User(id: "tempId4", name: "Gustav", username: "test", password: "test"))

    }
    
    func newConversation(name: String) {
        
        selectedUsers.append(currentUser)
        let conversation = Conversation(name: name, members: selectedUsers)
        selectedUsers.removeAll()
        
        dm.saveToFirestore(convo: conversation)
        self.listOfConversations.append(conversation)
        
    }
    
    func sendMessage(message: String, user: User, conversation: Conversation) {
        
        let newMessage = Message(timeStamp: Date.now, sender: user, text: message)
        conversation.messages.append(newMessage)
        dm.updateFirestore(conversation: conversation, message: newMessage)
        
        self.refresh += 1
        
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
