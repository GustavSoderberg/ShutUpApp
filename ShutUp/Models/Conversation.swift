//
//  Conversation.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

class Conversation: Identifiable {
    
    let id: UUID
    var name: String
    var members: [User]
    var messages: [Message]
    
    init(name: String, members: [User]) {
        
        self.id = UUID()
        self.name = name
        self.members = members
        self.messages = [Message]()
        
    }
    
}
