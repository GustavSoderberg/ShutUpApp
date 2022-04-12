//
//  CreditView.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-08.
//

import SwiftUI

struct Credits: View {

    var body: some View {

        HStack{

            Image(systemName: "scribble.variable")
                .font(.system(size: 25))
                .padding()
                .foregroundColor(Color.purple)
                .symbolRenderingMode(.multicolor)
            Spacer()
            Text("Credits")
                Spacer()
//            Image(systemName: "greaterthan")
//                .padding()

        }

    }
}

