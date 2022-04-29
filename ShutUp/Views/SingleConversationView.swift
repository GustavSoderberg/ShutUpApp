/**
 
 - Description:
 The SingleConversationView.swift is a View that displays messages from a single conversation as well as a button for sending new messages
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

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
    @State var showSettingsView = false
    
    @State var message = ""
    
    var body: some View {
        
        if !convoM.listOfConversations.isEmpty && convoM.listOfConversations.count > index {
            
            VStack{
                
                ScrollViewReader { proxy in
                    
                    ScrollView() {
                        
                        Spacer()
                        
                        VStack {
                            
                                ForEach(Array(convoM.listOfConversations[index].messages.enumerated()), id: \.offset) { idx, message in
                                    
                                    MessageBubble(message: message)
                                        .id(idx)
                                    
                                }
                            
                        }
                        
                        
                        Spacer()
                    }
                    .onChange(of: keyboardManager.isVisible) { newValue in
                        print(keyboardManager.isVisible)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            withAnimation{
                                proxy.scrollTo(convoM.listOfConversations[index].messages.count - 1, anchor: .bottom)
                            }
                            
                        }
                        
                        keyboardManager.isVisible = false
                        
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
                        
                        if cm.isConnected {
                            if !message.isEmpty {
                                convoM.sendMessage(message: message, user: um.currentUser!, conversation: convoM.listOfConversations[index])
                                message = ""
                            } else {
                                message = "👍"
                                convoM.sendMessage(message: message, user: um.currentUser!, conversation: convoM.listOfConversations[index])
                                message = ""
                            }
                        }
                        
                        
                    } label: {
                        
                        if message.isEmpty {
                            Text("👍")
                        }
                        else {
                            Text("Send")
                        }
                        
                        
                    }.padding()
                    
                }
                .navigationBarTitle(convoM.listOfConversations[index].name).navigationBarTitleDisplayMode(.inline)
                
                
            }
        }
        
    }
    
}

/**
 A view for displaying a single message in a conversation. It get's aligned and colored based on if the user is the currentUser or not
 */

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
                    
                        .fontWeight(.light)
                        .foregroundColor(um.currentUser!.id == message.senderID ? Color.white : Color.black)
                        .padding()
                        .background(um.currentUser!.id == message.senderID ? Color.blue : Color(UIColor(named: "customGray")!))
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

