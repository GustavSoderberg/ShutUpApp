/**
 
 - Description:
 The ConversationManager.swift is a ViewModel for the different conversation views that handles the interactions with the user
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ConversationManager: ObservableObject {
    
    var selectedUsers = [User]()
    @Published var listOfConversations = [Conversation]()
    @Published var refresh = 0
    var index = 0
    var isConnected = false
    
    func newConversation(name: String) {
        
        selectedUsers.append(um.currentUser!)
        let conversation = Conversation(name: name, members: selectedUsers)
        selectedUsers.removeAll()
        
        dm.saveToCoredata(conversation: conversation)
        dm.saveToFirestore(convo: conversation)
        self.listOfConversations.append(conversation)
        
    }
    
    func sendMessage(message: String, user: User, conversation: Conversation) {
        
        let newMessage = Message(id: UUID(), timeStamp: Date.now, senderID: user.id, text: message)
        conversation.messages.append(newMessage)
        
        //dm.updateCoredata(conversation: conversation, message: newMessage)
        dm.updateFirestore(conversation: conversation, message: newMessage)
        
    }
    
    func updateConversation(id: Conversation.ID) -> Conversation? {
        
        for conversation in listOfConversations {
            
            if conversation.id == id {
                refresh += 1
                return conversation
            }
            
        }
        
        return nil
        
    }
    
    func deleteConversation(conversation: Conversation) {
        
        dm.deleteFromCoredata(conversation: conversation)
        dm.deleteFromFirestore(conversation: conversation)
        cm.refresh += 1
        
    }
    
    /**
        We're keeping track of which Users get selected for a new conversation with an array that gets modified with the following methods
     */
    
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
