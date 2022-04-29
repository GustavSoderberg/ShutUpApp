/**
 
 - Description:
 A View for diplaying a user in the new conversation sheet
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import SwiftUI

struct UserDisplay: View {

    var user: User

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

