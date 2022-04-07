//
//  ProfileViewItems.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-07.
//

import SwiftUI

struct ProfileViewItems: View {

    var name = ""
    var image : String = ""

    var body: some View {

        HStack{

            Image(image)
            Text(name)
            Image(systemName: "lessthan")

        }.frame(width: 200, height: 30)
            .background(Color(UIColor(named: "customGray")!))
            .cornerRadius(15)

    }
}

