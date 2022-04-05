//
//  Conversation.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation
import SwiftUI

class Conversation: Identifiable {
    
    let id: UUID
    var name: String
    var members: [User]
    var messages: [Message]
    var theme: Theme
    
    init(name: String, members: [User]) {
        
        self.id = UUID()
        self.name = name
        self.members = members
        self.messages = [Message]()
        self.theme = Theme(name: "Space", top: Color.black, background: Color.black, bottom: Color.black, bubbleS: Color.black, bubbleR: Color.black)
        
    }
    
}
