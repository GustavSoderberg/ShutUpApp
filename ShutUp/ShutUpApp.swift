/**
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import SwiftUI
import Firebase

@main
struct ShutUpApp: App {
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var nm = NetworkManager()
    
    init() {
        
        FirebaseApp.configure()
        if let networkStatus = nm.isConnected {
            cm.isConnected = networkStatus
        }
    }
    
    var body: some Scene {
        WindowGroup {
            
            ConversationView()
            
        }
    }
}
