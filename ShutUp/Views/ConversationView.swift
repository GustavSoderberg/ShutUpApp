/**
 
 - Description:
 The ConversationView.swift is our app main View that displays the users conversation as well as buttons for creating a new conversation, a search function etc.
 All our ViewModels are instanced from this view as singleton objects
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFacebookAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
import CoreData

//Global instances of a Singleton object
var cm = ConversationManager()
var dm = DataManager()
var um = UserManager()
let pc = PersistenceController.shared.container.viewContext


struct ConversationView: View {
    
    @Environment(\.managedObjectContext) private var coreData
    
    init() {
        
        dm.listenToFirestore()
        
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
                    
                    if let currentUser = Auth.auth().currentUser {
                        
                        if let photoUrl = currentUser.photoURL {
                            
                            Button{
                                withAnimation{
                                    
                                    if um.currentUser != nil && cm.isConnected {
                                        showProfileView = true
                                    }
                                }
                                
                            } label: {
                                
                                AsyncImage(url: photoUrl) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(50)
                                } placeholder: {
                                    if cm.isConnected{
                                        ProgressView()
                                        
                                    }
                                    else{
                                        Image("def_avatar")
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(50)
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                    
                    
                    Spacer()
                        
                        Text("Chats")
                            .font(.title2)
                    
                    
                    Spacer()
                    
                    Button {
                        
                        withAnimation{
                            
                            if um.currentUser != nil && cm.isConnected {
                                newConversationSheet = true
                            }
                            
                        }
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .foregroundColor(Color(UIColor(named: "customGray")!))
                            .offset(x: -10)
                        
                        
                    }
                    
                }.padding()
                
                if !cm.isConnected {
                    
                    
                    HStack{
                        Spacer()
                        Label("You have no internet connection", systemImage: "wifi.slash")
                        Spacer()
                    }.padding().background(Color.red)
                        .foregroundColor(Color.white)
                    
                }
                
                
                ScrollView {
                    
                    VStack(alignment: .leading){
                        
                        Label() {
                            TextField("Search here...", text: $searchText).onSubmit({
                                print("hej")
                            })
                            
                            .foregroundColor(Color.black)
                            .accentColor(Color.white)
                            
                            
                        } icon: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        }
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(50)
                        .onTapGesture {
                            onTapped.toggle()
                            
                        }
                        
                        if um.isLoading {
                            
                            ProgressView()
                            
                        }
                        else if cm.listOfConversations.isEmpty {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("You have no conversations")
                                    
                                    
                                    Spacer()
                                }
                                Button {
                                    if cm.isConnected {
                                        newConversationSheet = true
                                    }
                                } label: {
                                    Text("Start chatting now")
                                }
                            }.padding(.top, 100)
                            
                        }
                        
                        else {
                            ForEach(Array(convoM.listOfConversations.enumerated()), id: \.offset) { index, convo in
                                
                                if let cu = um.currentUser {
                                    
                                    if (convo.members.contains(cu) && searchText.isEmpty) || (convo.members.contains(cu) && convo.name.lowercased().contains(searchText.lowercased())){
                                        HStack(spacing: 10){
                                            
                                            
                                            NavigationLink {
                                                
                                                SingleConversationView(index: index)
                                                    .onAppear {
                                                        showDelete = false
                                                    }          
                                                
                                                
                                            } label:{
                                                
                                                
                                                ChatPreview(convo: convo)
                                                    .gesture(DragGesture(minimumDistance: 75, coordinateSpace: .local)
                                                        .onEnded({ value in
                                                            if cm.isConnected && value.translation.width < 0 {
                                                                
                                                                selectedConvo = index
                                                                withAnimation{
                                                                    showDelete = true
                                                                }
                                                                
                                                            }
                                                            if cm.isConnected && value.translation.width > 0 {
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

                                                        cm.deleteConversation(conversation: convo)
                                                        selectedConvo = -1
                                                        showDelete = false

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
                                                    
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                }
                            }.padding()
                            Spacer()
                        }
                        
                        
                        
                    }
                    .padding([.leading, .bottom, .trailing], 20)
                    .navigationBarHidden(true)
                    .sheet(isPresented: $newConversationSheet,onDismiss: {
                        cm.selectedUsers.removeAll()
                        cm.refresh += 1
                    }) {
                        NewConversationView(newConversationSheet: $newConversationSheet, convoName: $convoName)
                        
                    }
                }
                
                
            }
            
            
        }
        .onAppear(perform: {
            if Auth.auth().currentUser == nil{
                
                showWelcomeView = true
                
            }
            
        })
        .sheet(isPresented: $showWelcomeView) {
            WelcomeView(showWelcomeView: $showWelcomeView)
        }
        .sheet(isPresented: $showProfileView) {
            ProfileView(showWelcomeView: $showWelcomeView, showProfileView: $showProfileView, user: um.currentUser!)
        }
    }
}

/**
 A View for selecting and creating a new conversation
 */


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
                        UserDisplay(user: user)
                    } else if convoM.selectedUsers.contains(user) {
                        UserDisplay(user: user)
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
            
            TextShimmer(text: "Continue")
            
        }
        
    }
    
}
