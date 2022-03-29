//
//  User.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

struct User: Identifiable {
    
    let id = UUID()
    var name: String
    let username: String
    var password: String
    
}
