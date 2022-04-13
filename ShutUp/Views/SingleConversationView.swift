//
//  SingleConversationView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine



struct SingleConversationView: View {
    
    @ObservedObject var keyboardManager = KeyboardManager()
    @State var scrollView: UIScrollView? = nil
    @State var keyboardHeight = CGFloat(0)
    
    var index: Int
    @ObservedObject var convoM = cm
    @State var conversation: Conversation?
    @State var showSettingsView = false
    var getMembers = GetMembers()
    
    @State var message = ""
    
    var body: some View {
        
        VStack{
            
            ScrollViewReader { proxy in
                
                ScrollView() {
                    
                    Spacer()
                    
                    //HStack{
                    
                    VStack {
                        
                        if !convoM.listOfConversations.isEmpty {
                            
                            ForEach(Array(convoM.listOfConversations[index].messages.enumerated()), id: \.offset) { idx, message in
                                
                                MessageBubble(message: message)
                                    .id(idx)
                                
                            }
                            
                        }
                        //Text("\(message.timeStamp.formatted()):\n\(message.text)").padding()
                    }
                    
                    
                    Spacer()
                    //                }
                    //                Spacer()
                }
                .onChange(of: keyboardManager.isVisible) { newValue in
                    print(keyboardManager.isVisible)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation{
                            proxy.scrollTo(convoM.listOfConversations[index].messages.count - 1, anchor: .bottom)
                        }
                        
                    }
                    
                    

                    keyboardManager.isVisible = false

                    
                    print("im here" )
                }
                
                .onAppear{
                    proxy.scrollTo(convoM.listOfConversations[index].messages.count - 1, anchor: .bottom)
                    
                }
                
                .onChange(of: convoM.listOfConversations[index].messages.count) { newValue in
                    
                    withAnimation{
                        proxy.scrollTo(convoM.listOfConversations[index].messages.count - 1, anchor: .bottom)
                    }
                    
                    
                }
                
                
            }
            
            HStack {
                
                TextField("message", text: $message).padding()
                
                Button {
                    
                    if !message.isEmpty {
                        convoM.sendMessage(message: message, user: um.currentUser!, conversation: conversation!)
                        message = ""
                    }
                    
                } label: {
                    
                    Text("Send")
                    
                }.padding()
                
            }.toolbar {
                Button {
                    showSettingsView = true
                } label: {
                    Image(systemName: "gear")
                }
                
            }
            .navigationBarTitle("\(getMembers.everybody(members: conversation!.members))".dropLast(2)).navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSettingsView) {
                SettingsView(showSettingsView: $showSettingsView, conversation: conversation!)
            }
            
            
        }

    }
    
}

struct GetMembers {
    
    func everybody(members: [User]) -> String {
        
        var rMembers = ""
        
        for member in members {
            
            if let cu = um.currentUser {
                if member.username != cu.username {
                    
                    rMembers += "\(member.username), "
                    
                }
            }
            
        }
        return rMembers
    }
}

struct MessageBubble : View{
    
    @ObservedObject var convoM = cm
    @State var showDate = false
    
    
    
    var message: Message
    
    var body: some View {
        
        VStack(alignment: um.currentUser!.id == message.senderID ? .trailing : .leading){
            
            HStack{
                VStack(alignment: um.currentUser!.id == message.senderID ? .trailing : .leading ){
                    
                    if showDate{
                        
                        Text(message.timeStamp.formatted())
                            .font(.system(size: 10))
                            .padding(.top, 10)
                    }
                    
                Text(message.text)
                             
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(um.currentUser!.id == message.senderID ? sm.currentTheme!.bubbleS : sm.currentTheme!.bubbleR)
                    .cornerRadius(30)
                                
                    
                    
                }
                
                
            }
            .frame(maxWidth: 300, alignment: um.currentUser!.id == message.senderID ? .trailing : .leading)
            
        }.onTapGesture {
            withAnimation{
                showDate = true
            }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    withAnimation{
                        showDate = false
                    }
                    
                    
                }
                
            
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: um.currentUser!.id == message.senderID ? .trailing : .leading)
        .padding(um.currentUser!.id == message.senderID ? .trailing : .leading)
        
    }
}

