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
                
                AsyncImage(url: URL(string: getPosition(convo: convo)[0].photoUrl)) { image in
                    
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
                        .offset(x: getPosition(convo: convo).count > 1 ? -8 : 0, y: getPosition(convo: convo).count > 1 ? 8 : 0)
                } placeholder: {
                    if cm.isConnected{
                        ProgressView()
                        
                    }
                    else{
                        Image("def_avatar")
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
                    }
                }
                if getPosition(convo: convo).count > 1 {
                    AsyncImage(url: URL(string: getPosition(convo: convo)[1].photoUrl)) { image in
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
                        if cm.isConnected{
                            ProgressView()
                            
                        }
                        else{
                            Image("def_avatar")
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
                        }
                    }
                }
                
                
            }.onAppear {
                _ = getPosition(convo: convo)
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
                    } else {
                        Text("There is no messages")
                            .italic()
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    
                }.padding(.top, -12)
                
            }
            
        }
    }
}

func getPosition(convo: Conversation) -> [User] {
    
    var array = convo.members
    
    for (index,user) in array.enumerated() {
        
        if user.id == um.currentUser!.id {
            
            array.remove(at: index)
            
        }
            
            
    }
    
    return array
    
}
