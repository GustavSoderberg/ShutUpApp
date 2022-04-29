/**
 
 - Description:
 The LogoutView.swift is a View that handles the confirmation of signing out a User
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import SwiftUI
import Firebase

struct LogoutView: View {

    @State var showingAlert: Bool
    @Binding var showProfileView : Bool
    @Binding var showWelcomeView: Bool

    var body: some View {

        ZStack{

            List{

                Button("Sign out current user") {
                    showingAlert = true
                }.buttonStyle(PlainButtonStyle())

                    .alert("Are you sure you wish to logout?", isPresented: $showingAlert) {
                        Button("Yes", role: .cancel) {

                            do {
                                um.currentUser = nil
                                showProfileView = false
                                showWelcomeView = true
                                try Auth.auth().signOut()
                            }
                            catch {
                                print(error)
                            }
                        }
                        Button("No") { }

                    }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor(named: "customGrayTwo")!))

        }
    }
}
