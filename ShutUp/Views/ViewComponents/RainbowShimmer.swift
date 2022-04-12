//
//  RainbowShimmer.swift
//  ShutUp
//
//  Created by Yolanda Jonasson on 2022-03-29.
//

import SwiftUI

struct TextShimmer: View {

    var text: String
    @State var animation = false

    var body: some View {

        ZStack{
            Text(text)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.white.opacity(0.55))

            //Multicolor text...

//            HStack(spacing: 0) {
//                ForEach(0..<text.count){index in
//                    
//                    Text(String(text[text.index(text.startIndex, offsetBy:
//                                                    index)]))
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(randomColor())
//                }
//           }

            // Masking for shimmer effect
            .mask(
                Rectangle()
                // For some more effect we use gradient
                    .fill(

                        LinearGradient(gradient: .init(colors:
                                                        [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]),
                                       startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(0)
                    .offset(x: -100)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                DispatchQueue.main.async {
                    withAnimation(Animation.linear(duration:
                    3).repeatForever(autoreverses: false)){
                        animation.toggle()
                    }
                }
            })
        }
    }

    func randomColor() -> Color {
        let color = UIColor(red: .random(in: 0...1), green: .random(in: 0...1),
                            blue: .random(in: 0...1), alpha: 1)

        return Color(color)
    }
}
