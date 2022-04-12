//
//  WelcomeView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-01.
//

import SwiftUI
import Firebase

struct WelcomeView: View {
    
    @Binding var showWelcomeView : Bool
    @State private var username: String = ""
    var auth = Auth.auth()
    
    var body: some View {
        
        Spacer()
        VStack {
            
            HStack {
                
                VStack {
                    
                    TextField(
                        "Username",
                        text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(Color.black)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .frame(width: 250.0)
                    .multilineTextAlignment(.leading)
                    .padding(/*@START_MENU_TOKEN@*/[.top, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                    .padding(/*@START_MENU_TOKEN@*/.horizontal, 45.0/*@END_MENU_TOKEN@*/)
                    
                    
                    Button(action: {
                        
                        if !username.isEmpty && um.login(username: username) {
                            
                            showWelcomeView = false
                            
                        }
                        
                    }) {

                            HStack{

                            Text("Sign in with your email")
                                .bold()
                                .foregroundColor(Color.black)
                                .frame(width: 250, height: 50)

                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color.blue)
                            }.padding()
                            .shadow(color: Color.blue, radius: 20, x:0, y:0)
                            .clipShape(Capsule())
                    }
                    
                }
                
            }
            
        }.interactiveDismissDisabled()
        Spacer()
        
    }
}
