/**
 
 - Description:
 The User.swift is a Model for a user object
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import Foundation


struct User: Identifiable, Equatable, Codable {
    
    
    let id: String
    let username: String
    let photoUrl: String
    
}
