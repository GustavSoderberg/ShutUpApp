//
//  TitleRow.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-03-30.
//

import SwiftUI

struct ChatPreview: View {
    
    var convo: Conversation
    
    var imageURL = URL(string: "https://cdn.discordapp.com/attachments/958000950046494780/958656460068380702/modelpic2.png")
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            ZStack{
                
                AsyncImage(url: imageURL) { image in
                    
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(50)
                        .zIndex(2)
                        .shadow(color: Color.black, radius: 3, x: 0, y: 0)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: -8, y: 8)
                } placeholder: {
                    ProgressView()
                }
                
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(50)
                        .zIndex(1)
                        .shadow(color: Color.black, radius: 3, x: 0, y: 0)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: 10, y: -10)
                    
                } placeholder: {
                    ProgressView()
                }
                
            }
            
            VStack(alignment: .leading){
                Text(convo.name)
                    .font(.headline)
                    .fontWeight(.thin)
                    .lineLimit(1)
                
                HStack{
                    if convo.messages.count > 0 {
                        Text("\(convo.messages.last!.text)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                    
                }.padding(.top, -12)
                
            }
            
        }
    }
}
