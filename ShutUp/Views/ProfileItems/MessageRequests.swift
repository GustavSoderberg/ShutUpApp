//
//  MessageRequests.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-11.
//

import SwiftUI

struct MessageRequests: View {

    var body: some View {

        HStack{

            Image(systemName: "message.circle.fill")
                .font(.system(size: 25))
                .padding()
                .foregroundColor(Color.blue)
            Spacer()
            Text("Meddelandeförfrågningar")
                Spacer()
//            Image(systemName: "greaterthan")
//                .padding()

        }
        //.frame(width: 0.95 * UIScreen.main.bounds.width, height: 45)
            .background(Color.white)
            .cornerRadius(10)

    }
}
