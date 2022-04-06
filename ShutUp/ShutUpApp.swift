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
    
    init() {
        FirebaseApp.configure()
        
        let auth = Auth.auth()
        
        auth.signInAnonymously { authResult, error in
            guard let _ = authResult?.user else { return }
            dm.listenToFirestore()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ConversationView()
        }
    }
}
