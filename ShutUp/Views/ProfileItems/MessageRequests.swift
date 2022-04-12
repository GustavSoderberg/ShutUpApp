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
                .symbolRenderingMode(.multicolor)
            Spacer()
            Text("Message Requests")
                Spacer()
//            Image(systemName: "greaterthan")
//                .padding()

        }

    }
}
