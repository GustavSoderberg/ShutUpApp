//
//  Message.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

struct Message: Identifiable {
    
    let id = UUID()
    let timeStamp: Date
    let sender: User
    let text: String
    
    
    
    
}
