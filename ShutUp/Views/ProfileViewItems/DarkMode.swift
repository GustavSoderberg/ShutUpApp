//
//  ProfileViewItems.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-07.
//

import SwiftUI

struct DarkMode: View {

    var body: some View {


        HStack{

            Image(systemName: "moon.circle.fill")
            Text("Dark Mode")
            Image(systemName: "lessthan")

        }.frame(width: 0.8 * UIScreen.main.bounds.width, height: 30)
            .background(Color(UIColor(named: "customGray")!))
            .cornerRadius(15)

    }
}


