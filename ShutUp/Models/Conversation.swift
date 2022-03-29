//
//  Conversation.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

class Conversation: Identifiable {
    
    let id: UUID
    var members: [User]
    var messages: [Message]
    
    init(members: [User]) {
        
        self.id = UUID()
        self.members = members
        self.messages = [Message]()
        
    }
    
}
