//
//  DarkMode.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-08.
//

import SwiftUI

struct DarkMode: View {

    var body: some View {

        HStack{

            Image(systemName: "moon.circle.fill")
                .font(.system(size: 25))
                .padding()
                .foregroundColor(Color.black)
                .symbolRenderingMode(.multicolor)
            Spacer()
            Text("Dark Mode")
                Spacer()

        }

    }
}
