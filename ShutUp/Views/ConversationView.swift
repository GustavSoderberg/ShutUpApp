//
//  ContentView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI

struct ConversationView: View {
    
    @ObservedObject var convoM = ConversationManager(user: User(name: "you", username: "gustav", password: "123"))
    @State var newConversationSheet = false
    @State var convoName = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                ForEach(convoM.listOfConversations) { convo in
                    
                    NavigationLink {
                        
                        SingleConversationView(convoM: convoM, conversation: convo)
                        
                    } label: {
                        
                        Text("\(convo.name)")
                        
                    }

                }.padding()
                
                Spacer()
                
                Button {
                    
                    newConversationSheet = true
                    
                } label: {

                    //Text("New conversation")

                    ZStack{
                        Text("New conversation")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.blue.opacity(1))
                        TextShimmer(text: "New conversation")
                    }
                }
                
            }.sheet(isPresented: $newConversationSheet) {
                if convoM.selectedUsers.count > 0 {
                    convoM.newConversation(name: convoName)
                    convoName = ""
                }
            } content: {
                NewConversationView(newConversationSheet: $newConversationSheet, convoName: $convoName, convoM: convoM)
            }
        }
    }
}

struct NewConversationView : View{
    
    @Binding var newConversationSheet: Bool
    @Binding var convoName: String
    @ObservedObject var convoM: ConversationManager
    
    var body: some View {
        
        Spacer()
        
        ForEach(convoM.listOfUsers) { user in
            
            Button {
                if !convoM.selectedUsers.contains(user) {
                    convoM.select(user: user)
                } else if convoM.selectedUsers.contains(user) {
                    convoM.unselect(userToRemove: user)
                }
                
                for user in convoM.selectedUsers {
                    print(user.name)
                }
                
            } label: {
                
                if !convoM.selectedUsers.contains(user) {
                    Text(user.name).padding()
                } else if convoM.selectedUsers.contains(user) {
                    Text(user.name)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }
            
        }
        
        Spacer()
        
        Text("Conversation name:")
        TextField("Type here...", text: $convoName)
            .multilineTextAlignment(.center)
            .padding()
        
        Button {
            if convoM.selectedUsers.count > 0 {
                if convoName.isEmpty {
                    
                    var temp = ""
                    
                    for user in convoM.selectedUsers {
                        
                        temp += "\(user.name) & "
                        
                    }
                    
                    convoName += temp.dropLast(3)

                }
                newConversationSheet = false
            }
        } label: {
            Text("Continue")
        }

    }
    
}

//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationView()
//    }
//}
