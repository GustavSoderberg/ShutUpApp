/**
 
 - Description:
 The ProfileView.swift is a view that displays different options for the logged in user
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */


import SwiftUI
import Firebase

struct ProfileView: View {
    
    @Binding var showWelcomeView : Bool
    @Binding var showProfileView : Bool
    
    var user: User
    
    
    var body: some View {
        
        ZStack{
            
            NavigationView {
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    //MARK: DONE BUTTON
                    
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                showProfileView = false
                            }, label: {
                                Text("Done")
                                    .foregroundColor(Color.blue)
                            }).padding(.trailing, 20.0)
                                .padding(.top, 10.0)
                        }
                        
                        //MARK: PROFILE IMAGE VSTACK
                        
                        List {
                            VStack(spacing: 0) {
                                
                                
                                HStack {
                                    Spacer()
                                    AsyncImage(url: URL(string: um.currentUser!.photoUrl)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(50)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Spacer()
                                }
                                Text(user.username)
                                    .font(.system(size: 28))
                                
                            }.padding(.vertical, 25)
                            
                            Section(header: Text("User settings")) {
                                
                                //MARK: Account settings
                                
                                NavigationLink {
                                    AccountSettingsView()
                                } label: {
                                    AccountSettings()
                                }.buttonStyle(PlainButtonStyle())
                                
                                
                                //MARK: Change account
                                
                                NavigationLink {
                                    LogoutView(showingAlert: false, showProfileView: $showProfileView, showWelcomeView: $showWelcomeView)
                                } label: {
                                    ChangeAccount()
                                }.buttonStyle(PlainButtonStyle())
                            }
                            Section(header: Text("Other")) {
                                
                                //MARK: Credits
                                
                                NavigationLink {
                                    CreditsView()
                                } label: {
                                    Credits()
                                }.buttonStyle(PlainButtonStyle())
                                
                                //MARK: Sekretess
                                
                                NavigationLink {
                                    PrivacyView()
                                } label: {
                                    Privacy()
                                }.buttonStyle(PlainButtonStyle())
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    .navigationBarHidden(true)
                    .navigationBarItems(trailing: Button(action: {
                        showProfileView = false
                    }, label: {
                        Text("Done")
                    }))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor(named: "customGrayTwo")!))
                }
            }
        }
    }
    
    
}
