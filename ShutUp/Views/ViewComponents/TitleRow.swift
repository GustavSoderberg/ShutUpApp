//
//  TitleRow.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-03-30.
//

import SwiftUI

struct TitleRow: View {

    var user: User

    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")

    var body: some View {
        HStack(spacing: 20) {

            AsyncImage(url: URL(string: user.photoUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading){
                Text("\(user.username)")
                    .font(.title).bold()
                    .lineLimit(1)


                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

        }.padding(.leading, 10)
            .frame(width: 0.8*UIScreen.main.bounds.width, height: 70, alignment: .leading)

    }
}

