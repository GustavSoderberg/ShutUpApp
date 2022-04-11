//
//  DarkModeSettings.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-04-10.
//

import SwiftUI

struct DarkModeSettings: View {
    var body: some View {

        ZStack{

            List{

                Button {

                } label: {
                    Text("På")
                }

                Button {

                } label: {
                    Text("Av")
                }

                Button {

                } label: {
                    Text("System")
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor(named: "customGrayTwo")!))

    }
}


