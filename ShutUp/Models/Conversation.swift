/**
 
 - Description:
 The Conversation.swift is a Model for a conversation object
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

class Conversation: Identifiable, Codable {
    
    @DocumentID var id : String?
    var uid: UUID
    var name: String
    var members: [User]
    var messages: [Message]
    
    init(name: String, members: [User]) {
        
        self.uid = UUID()
        self.name = name
        self.members = members
        self.messages = [Message]()
        
    }
    
    init(uid: UUID, name: String, members: [User], messages: [Message] ) {
        
        self.uid = uid
        self.name = name
        self.members = members
        self.messages = messages
        
    }
    
}
