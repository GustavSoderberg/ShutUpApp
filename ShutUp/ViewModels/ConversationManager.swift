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
    @Published var listOfConversations = [Conversation]()
    @Published var refresh = 0
    
    init(user: User) {
        
        self.currentUser = user
        
    }
    
    func newConversation(members: [User]) {
        
        let conversation = Conversation(members: members)
        
        self.listOfConversations.append(conversation)
        
    }
    
    func sendMessage(message: String, user: User, conversation: Conversation) {
        
        conversation.messages.append(Message(timeStamp: Date.now, sender: user, text: message))
        self.refresh += 1
        
    }
    
}
