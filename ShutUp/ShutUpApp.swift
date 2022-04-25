//
//  ShutUpApp.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI
import Firebase

@main
struct ShutUpApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var nm = NetworkManager()
    
    init() {
        
        FirebaseApp.configure()
        cm.isConnected = nm.isConnected!
    }
    
    var body: some Scene {
        WindowGroup {
            
            ConversationView()
//                .ignoresSafeArea(.keyboard)
                //.environment(\.colorScheme, .dark)
        }
    }
}
