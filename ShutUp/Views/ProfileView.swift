//
//  ProfileView.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-07.
//

//
//  WelcomeView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-01.
//

import SwiftUI
import Firebase

struct ProfileView: View {

    @Binding var showWelcomeView : Bool
    @Binding var showProfileView : Bool
    
    var user: User
    
    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")
    
    
    var body: some View {
        
        ZStack{
            
            NavigationView {
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    //MARK: KLAR Knappen ------------------------------------------------------------------------
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
                        
                        //MARK: PROFILE IMAGE VSTACK ----------------------------------------------------------------
                        
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
                            
                            //MARK: DarkModeSettings -------------------------------------
                            
//                            NavigationLink {
//                                DarkModeSettings()
//                            } label: {
//                                DarkMode()
//                            }.buttonStyle(PlainButtonStyle())

//MARK: Toggle ActivityStatus ------------------------------
                            
                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                ActivityStatus()
                            }.buttonStyle(PlainButtonStyle())

                            
//MARK: Change account -------------------------------------
                            
                            NavigationLink {
                                LogoutView(showingAlert: false, showProfileView: $showProfileView, showWelcomeView: $showWelcomeView)
                            } label: {
                                ChangeAccount()
                            }.buttonStyle(PlainButtonStyle())
                        }
                            Section(header: Text("Other")) {
//MARK: Credits --------------------------------------------
                            
                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                Credits()
                            }.buttonStyle(PlainButtonStyle())
                            
//MARK: Sekretess ------------------------------------------
                            
                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                Privacy()
                            }.buttonStyle(PlainButtonStyle())
                            
//MARK: Meddelandeförfrågningar -------------------------------------
                            
//                            NavigationLink {
//                                DarkModeSettings()
//                            } label: {
//                                MessageRequests()
//                            }.buttonStyle(PlainButtonStyle())
                            
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
