//
//  ContentView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI

//Global instance of a Singleton object
var cm = ConversationManager()

struct ConversationView: View {
    
    @ObservedObject var convoM = cm
    @State var newConversationSheet = false
    @State var convoName = ""
    @State var searchText = ""
    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")

    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    
                    
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                        } placeholder: {
                            ProgressView()
                        }
                    
                    Label() {
                        TextField("Search here...", text: $searchText)
                    } icon: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                    }.padding()
                    
                    Button {
                        newConversationSheet = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                        
                    }

                    
                }.padding()
                
                ScrollView {
                    
                    VStack{
                        
                        ForEach(convoM.listOfConversations) { convo in
                            
                            NavigationLink {
                                
                                SingleConversationView(conversation: convo)
                                
                            } label: {
                                ChatPreview()
                                //Text("\(convo.name)")
                                
                            }
                            
                        }.padding()
                        
                        ChatPreview()
                        
                        Spacer()
                        
                    }.navigationBarHidden(true)
                        .sheet(isPresented: $newConversationSheet) {
                        NewConversationView(newConversationSheet: $newConversationSheet, convoName: $convoName)
                    }
                }
                    
                }
                
                
        }
    }
}

struct NewConversationView : View{
    
    @Binding var newConversationSheet: Bool
    @Binding var convoName: String
    @ObservedObject var convoM = cm
    
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
                        
                        convoName += temp.dropLast(3)
                        convoM.newConversation(name: convoName)
                    }
                    
                }
                
                convoName = ""
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
