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

    @Binding var showProfileView : Bool

    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")

    var body: some View {

        ZStack{

            NavigationView {

                VStack(spacing: 0) {

                    Spacer()

//MARK: KLAR Knappen ------------------------------------------------------------------------
                    
                    HStack{
                    Spacer()
                    Button(action: {
                        showProfileView = false
                    }, label: {
                        Text("Klar")
                            .foregroundColor(Color.blue)
                    }).padding(.trailing, 20.0)
                      .padding(.top, 20.0)
                    }

//MARK: PROFILE IMAGE VSTACK ----------------------------------------------------------------

                    VStack(spacing: 0) {

                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(50)

                        } placeholder: {
                            ProgressView()
                        }

                        Text("Andreas Jonasson")
                        //.font(.headline)
                            .font(.system(size: 28))

                    }


                    List {


                        Section(header: Text("Important Tasks")) {

//MARK: DarkModeSettings -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                DarkMode()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Toggle ActivityStatus -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                ActivityStatus()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Change account -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                ChangeAccount()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Credits -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                Credits()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Sekretess -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                Sekretess()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Meddelandeförfrågningar -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                MessageRequests()
                            }.buttonStyle(PlainButtonStyle())

                        }

//MARK: SECTION TWO LETS GO

                        Section(header: Text("Less Important Tasks")) {

//MARK: DarkModeSettings -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                DarkMode()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Toggle ActivityStatus -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                ActivityStatus()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Change account -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                ChangeAccount()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Credits -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                Credits()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Sekretess -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                Sekretess()
                            }.buttonStyle(PlainButtonStyle())

//MARK: Meddelandeförfrågningar -------------------------------------

                            NavigationLink {
                                DarkModeSettings()
                            } label: {
                                MessageRequests()
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .navigationBarHidden(true)
                .navigationBarItems(trailing: Button(action: {
                    showProfileView = false
                }, label: {
                    Text("Klart")
                }))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor(named: "customGrayTwo")!))
            }
        }
    }
}


