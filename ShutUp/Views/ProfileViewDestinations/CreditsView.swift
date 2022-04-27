//
//  CreditsView.swift
//  ShutUp
//
//  Created by Calle Höglund on 2022-04-26.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack{
            
            Text("🏆")
                .font(.headline)
                .padding([.leading, .bottom, .trailing], 40)
            
            Text("Thanks to \n\n\nGustav \nAndreas \nCalle \n\n\nfor making this app...")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .font(.headline)
            
            Image("swish")
                .resizable()
                .frame(width: 100, height: 100)
            
        }
        
            
            
            
    }
}
