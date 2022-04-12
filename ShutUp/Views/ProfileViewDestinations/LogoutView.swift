//
//  LogoutView.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-12.
//

//
//  DarkModeSettings.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-10.
//

import SwiftUI

struct LogoutView: View {

    @State var showingAlert: Bool

    var body: some View {

        ZStack{

            List{

                Button("Sign out current user") {
                    showingAlert = true
                }.buttonStyle(PlainButtonStyle())

                .alert("Are you sure you wish to logout?", isPresented: $showingAlert) {
                    Button("Yes", role: .cancel) { }
                    Button("No") { }
                    





            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor(named: "customGrayTwo")!))

    }
}


}
