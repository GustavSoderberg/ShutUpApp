//
//  SingleConversationView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI

struct SingleConversationView: View {
    
    @ObservedObject var convoM = cm
    @State var conversation: Conversation?
    @State var showSettingsView = false
    var getMembers = GetMembers()
    
    @State var message = ""
    
    var body: some View {
        
        Text("This is a conversation between\n\(getMembers.everybody(members: conversation!.members))")
            .multilineTextAlignment(.center)
        
        Divider()
        
        ScrollView(showsIndicators: false) {
            
            Spacer()
            
            HStack{
                
                VStack {
                    
                    ForEach(conversation!.messages) { message in
                        
                        MessageBubble(message: message)
                        //Text("\(message.timeStamp.formatted()):\n\(message.text)").padding()
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
            
        }.toolbar {
            Button {
                showSettingsView = true
            } label: {
                Image(systemName: "gear")
            }

        }.sheet(isPresented: $showSettingsView) {
            SettingsView(showSettingsView: $showSettingsView)
        }
        
    }
    
}

struct GetMembers {
    
    func everybody(members: [User]) -> String {
        
        var rMembers = ""
        let secondLastIndex = members.count - 1
        let thirdLastIndex = members.count - 2
        
        
        
        for member in members {
            
            //            rMembers += ""
            if members[secondLastIndex] == member{
                rMembers += "and \(member.name)"
            }else if members[thirdLastIndex] == member{
                rMembers += "\(member.name) "
            }
            else {
                rMembers += "\(member.name), "
            }
            
            //            if numberOfMembers >= 2 {
            //
            //                rMembers += "\(member.name), "
            ////                numberOfMembers -= 1
            //
            //            } else if numberOfMembers <= 1{
            //
            //                rMembers += "\(member.name) and "
            //
            //            }
        }
        
        return rMembers
        
    }
    
}

struct MessageBubble : View{
    
    var convoM = cm
    var message: Message
    
    var body: some View {
        
        VStack(alignment: convoM.currentUser == message.sender ? .trailing : .leading){
            
            HStack{
                Text(message.text)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(convoM.currentUser == message.sender ? sm.themes[Conversation.theme]![0] : sm.themes["space"]![1])
                    .cornerRadius(30)
                
            }
            .frame(maxWidth: 300, alignment: convoM.currentUser == message.sender ? .trailing : .leading)
            
        }
        .frame(maxWidth: .infinity, alignment: convoM.currentUser == message.sender ? .trailing : .leading)
        .padding(convoM.currentUser == message.sender ? .trailing : .leading)
        
        
    }
    
    
    
}



//struct SingleConversationView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        SingleConversationView(convoM: <#ConversationManager#>)
//    }
//}
