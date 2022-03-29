//
//  ContentView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI

struct ConversationView: View {
    
    @ObservedObject var convoM = ConversationManager(user: User(name: "Gustav", username: "gustav", password: "123"))
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                ForEach(convoM.listOfConversations) { convo in
                    
                    NavigationLink {
                        
                        SingleConversationView(convoM: convoM, conversation: convo)
                        
                    } label: {
                        
                        Text("\(convo.id)")
                        
                    }
                    
                    
                }.padding()
                
                Spacer()
                
                Button {
                    
                    convoM.newConversation(members: [convoM.currentUser,
                                                     User(name: "Andreas", username: "test", password: "test"),
                                                     User(name: "Calle", username: "test", password: "test")])
                    
                } label: {
                    
                    Text("New conversation")
                }
                
            }
            
        }
        
        
    }
}

//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationView()
//    }
//}
