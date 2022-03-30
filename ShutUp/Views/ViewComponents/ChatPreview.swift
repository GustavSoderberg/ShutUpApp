//
//  TitleRow.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-03-30.
//

import SwiftUI

struct ChatPreview: View {

    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")
    var name = "Dummy Jonasson"

    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading){
                Text(name)
                    .font(.title).bold()

                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

//            Image(systemName: "phone.fill")
//                .foregroundColor(.gray)
//                .padding(10)
//                .background(.white)
//                .cornerRadius(50)

        }
    }
}

struct ChatPreview_Previews: PreviewProvider {
    static var previews: some View {
        ChatPreview()
    }
}

