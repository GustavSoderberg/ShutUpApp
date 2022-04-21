//
//  User.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    
    let id: String
    let username: String
    let photoUrl: String
    
}
