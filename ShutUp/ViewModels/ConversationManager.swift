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
    
    init() {
        
        self.currentUser = User(name: "you", username: "gustav", password: "123")
        listOfUsers.append(User(name: "Andreas", username: "test", password: "test"))
        listOfUsers.append(User(name: "Calle", username: "test", password: "test"))
        listOfUsers.append(User(name: "Gustav", username: "test", password: "test"))

    }
    
    func newConversation(name: String) {
        
        selectedUsers.append(currentUser)
        let conversation = Conversation(name: name, members: selectedUsers)
        selectedUsers.removeAll()
        
        self.listOfConversations.append(conversation)
        
    }
    
    func sendMessage(message: String, user: User, conversation: Conversation) {
        
        conversation.messages.append(Message(timeStamp: Date.now, sender: user, text: message))
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
