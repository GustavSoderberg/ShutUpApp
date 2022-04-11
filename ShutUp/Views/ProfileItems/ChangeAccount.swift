//
//  ChangeAccount.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-08.
//

//
//  ActivityStatus.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-08.
//

import SwiftUI

struct ChangeAccount: View {

    var body: some View {

        HStack{

            Image(systemName: "switch.2")
                .font(.system(size: 25))
                .padding()
                .foregroundColor(Color.green)
            Spacer()
            Text("Byt Användare")
            Spacer()
            Image(systemName: "lessthan")
                .padding()

        }.frame(width: 0.95 * UIScreen.main.bounds.width, height: 40)
            .background(Color(UIColor(named: "customGray")!))
            .cornerRadius(10)

    }
}



