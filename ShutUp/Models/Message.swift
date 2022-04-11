//
//  Message.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

struct Message: Identifiable, Codable {
    
    let id = UUID()
    let timeStamp: Date
    let senderID: String
    let text: String
    
}
//
//extension Message: Hashable {
//    static func == (lhs: Message, rhs: Message) -> Bool {
//        return  lhs.id == rhs.id &&
//                lhs.timeStamp == rhs.timeStamp &&
//                lhs.sender == rhs.sender &&
//                lhs.text == rhs.text
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        hasher.combine(timeStamp)
//        hasher.combine(text)
//    }
//}
