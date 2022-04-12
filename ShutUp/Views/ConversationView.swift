//
//  ContentView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-03-28.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

//Global instances of a Singleton object
var auth = Auth.auth()

var cm = ConversationManager()
var sm = SettingsManager()
var dm = DataManager()
var um = UserManager()

struct ConversationView: View {
    
    init() {
        auth.signInAnonymously { authResult, error in
            guard let _ = authResult?.user else { return }
            dm.listenToFirestore()
        }
    }
    
    @ObservedObject var convoM = cm
    @State private var showProfileView = false
    @State private var showWelcomeView = false
    @State private var showDelete = false
    @State private var selectedConvo = -1

    @State var newConversationSheet = false
    @State var convoName = ""
    @State var searchText = ""
    @State var onTapped = false
    
    
    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {

                    Button{
                        withAnimation{
                            
                            if let cu = um.currentUser {
                                showProfileView.toggle()
                            }
                        }
                        
                    } label: {

                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(50)
                        } placeholder: {
                            ProgressView()
                        }

                    }
                    

                    Spacer()
                    
                    Text("Chats")
                        .font(.title2)
                    
                    Spacer()
                    
                    Button {
                            newConversationSheet = true
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .foregroundColor(Color(UIColor(named: "customGray")!))
                            .offset(x: -10)
                        
                        
                    }
                    
                }.padding()
                
                ScrollView {
                    
                    VStack(alignment: .leading){
                        
                        Label() {
                            TextField("Search here...", text: $searchText)
                            
                                .foregroundColor(Color.black)
                                .accentColor(Color.white)
                            
                            
                        } icon: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(50)
                        .onTapGesture {
                            onTapped.toggle()
                            
                        }
                        
                        ForEach(Array(convoM.listOfConversations.enumerated()), id: \.offset) { index, convo in
                            
                            if let cu = um.currentUser {
                                
                                
                                if convo.members.contains(cu){
                                    HStack(spacing: 10){
                                    
                                    NavigationLink {
                                        
                
                                            SingleConversationView(index: index, conversation: convo)
                                                .onAppear(perform: {
                                                    showDelete = false
                                                    print("navigationlink")
                                                    
                                                })
                                        
                                     } label:{
                                        
                                        
                                            ChatPreview(name: convo.name)
                                                
                                                .gesture(DragGesture(minimumDistance: 100, coordinateSpace: .local)
                                                .onEnded({ value in
                                                    if value.translation.width < 0 {
                                                        
                                                        selectedConvo = index
                                                        withAnimation{
                                                            showDelete = true
                                                        }
                                                        
                                                    }
                                                    if value.translation.width > 0 {
                                                        withAnimation{
                                                            showDelete = false
                                                        }
                                                        
                                                    }
                                                }))
                                            
                                            
                                            
                                            
                                            
                                     }
                                    
                                    Spacer()
                                        
                                if showDelete {
                                    if selectedConvo == index{
                                        
                                        
                                        Button(action: {
                                            dm.deleteFromFirestore(conversation: convo)
                                            selectedConvo = -1
                                            print("deletebutton")
                                            
                                        }, label: {
                                            
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(Color.white)
                                                .frame(width: 20, height: 20)
                                                .scaledToFit()
                                            
                                        })
                                            .frame(width: 50, height: 50)
                                            .background(Color.red)
                                            .cornerRadius(25)
                                            .transition(.scale)
                                        
    //                                        .onTapGesture {
    //
    //                                        }
                                            
                                            
                                            
                                        
                                    }
                                    
                                    
                                    
                                   
                                }
                                    
                                }
                                
                                
                                    
                                    
                                
                                
                                
                                }
                                
                            }
                        }.padding()
                        
                        Spacer()
                    }
                    .padding(20)
                    .navigationBarHidden(true)
                    .sheet(isPresented: $newConversationSheet) {
                        NewConversationView(newConversationSheet: $newConversationSheet, convoName: $convoName)
                            
                    }
                }
                
                
            }
            
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                showWelcomeView = um.loginCheck(uid: auth.currentUser!.uid)
                cm.refresh += 1
                
            }
        }
        .sheet(isPresented: $showWelcomeView) {
            WelcomeView(showWelcomeView: $showWelcomeView)
        }
        .sheet(isPresented: $showProfileView) {
            ProfileView(showProfileView: $showProfileView, user: um.currentUser!)
        }
    }
}

struct NewConversationView : View{
    
    @Binding var newConversationSheet: Bool
    @Binding var convoName: String
    @ObservedObject var convoM = cm
    
    var body: some View {
        
        Spacer()
        
        ForEach(um.listOfUsers) { user in
                
            if user.id != um.currentUser!.id {
                Button {
                    if !convoM.selectedUsers.contains(user) {
                        convoM.select(user: user)
                    } else if convoM.selectedUsers.contains(user) {
                        convoM.unselect(userToRemove: user)
                    }
                    
                    
                } label: {
                    
                    if !convoM.selectedUsers.contains(user) {
                        TitleRow(user: user)
                    } else if convoM.selectedUsers.contains(user) {
                        TitleRow(user: user)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
                .frame(width: 150, height: 70, alignment: .center)
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
                        
                        if let cu = um.currentUser {
                            
                            if user.username != cu.username {
                                
                                temp = "\(user.username), "
                                convoName += temp
                                
                         }
                        }
                        
                    }
                    
                    convoName =  String(convoName.dropLast(2))
                }
                
                convoM.newConversation(name: convoName)
                
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
