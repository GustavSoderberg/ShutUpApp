//
//  SingleConversationView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI

struct SingleConversationView: View {
    
    @ObservedObject var convoM: ConversationManager
    @State var conversation: Conversation?
    var getMembers = GetMembers()
    
    @State var message = ""
    
    var body: some View {
        
        
        Text("This is a conversation between:\n\(getMembers.everybody(members: conversation!.members))".dropLast(5))
            .multilineTextAlignment(.center)
        
        Divider()
        
        ScrollView {
            
            Spacer()
            
            HStack{
                
                VStack {
                    
                    ForEach(conversation!.messages) { message in
                        
                        Text("\(message.timeStamp.formatted()):\n\(message.text)").padding()
                        
                    }
                    
                }
                
                Spacer()
                
            }
            
            Spacer()
            
        }
        
        
        HStack {
            
            TextField("message", text: $message).padding()
            
            Button {
                
                convoM.sendMessage(message: message, user: convoM.currentUser, conversation: conversation!)
                message = ""
                
            } label: {
                
                Text("Send")
                
            }.padding()
            
        }
        
    }
    
}

struct GetMembers {
    
    func everybody(members: [User]) -> String {
        
        var rMembers = ""
        
        for member in members {
            
            rMembers += "\(member.name) and "
            
        }
        
        return rMembers
        
    }
    
}

//struct SingleConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleConversationView()
//    }
//}
