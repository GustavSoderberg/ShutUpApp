/**
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import SwiftUI

struct AccountSettings: View {

    var body: some View {


        HStack{

            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 25))
                .padding()
                .foregroundColor(Color.purple)
                .symbolRenderingMode(.multicolor)
            Spacer()
            Text("Account Settings")
            Spacer()
//            Image(systemName: "greaterthan")
//                .padding()

        }

    }
}


