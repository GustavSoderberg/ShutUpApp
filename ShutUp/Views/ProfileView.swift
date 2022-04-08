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

        Spacer()

        ZStack{ //incase we need a background

            VStack {

                Spacer()

                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                } placeholder: {
                    ProgressView()
                }

                Spacer()

                Text("Andreas Jonasson")
                    .font(.system(size: 26, weight: .light, design: .serif))

                ScrollView {

                    DarkMode()
                    DarkMode()
                    ActivityStatus()
                    DarkMode()
                    ActivityStatus()

                }
            }
        }
    }
}

