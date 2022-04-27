//
//  SettingsView.swift
//  ShutUp
//
//  Created by Gustav Söderberg on 2022-04-04.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSettingsView: Bool
    var conversation: Conversation
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            SelectionView(name: "Space theme", settings: "space", color: Color.black, showSettingsView: $showSettingsView)
            SelectionView(name: "Flower theme", settings: "flower", color: Color.green, showSettingsView: $showSettingsView)
            SelectionView(name: "Sunny theme", settings: "sun", color: Color.yellow, showSettingsView: $showSettingsView)
            
            Spacer()
            
            Button(action: {
                
                dm.deleteFromFirestore(conversation: conversation)
                showSettingsView = false
                ConversationView()
                
            }){
                Text("Remove conversation")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: 300)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
        }
    }
}

struct SelectionView: View {
    
    var name: String
    var settings: String
    var color: Color
    @Binding var showSettingsView: Bool
    
    var body: some View {
        
        Button {
            sm.setCurrentTheme(name: settings)
            showSettingsView = false
        } label: {
            HStack{
                Spacer()
                Rectangle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
                Spacer()
                Text(name)
                Spacer()
            }
            
        }
        
    }
    
}
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
