/**
 
 - Description:
 Our continue button for creating a new conversation has a text shimmer made by this View
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import SwiftUI

struct TextShimmer: View {

    var text: String
    @State var animation = false

    var body: some View {

        ZStack{
            Text(text)
                .bold()
            Text(text)
                .bold()
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.white.opacity(0.55))

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
