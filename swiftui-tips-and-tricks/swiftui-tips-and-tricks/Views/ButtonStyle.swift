//
//  ButtonStyle.swift
//  swiftui-tips-and-tricks
//
//  Created by luobobo on 2022/11/5.
//

import SwiftUI

struct CustomButtonStyle: View {
    var body: some View {
        VStack {
            Button {
                print("tap button")
            } label: {
                Text("Hello, World!")
                    .padding()
                    .background(Color.orange)
            }
            .buttonStyle(RoundedBorderedButton(stroke: Color.black, lineWidth: 2))
            
            Button {
                print("tap button")
            } label: {
                Text("Hello, World!")
                    .padding()
                    .background()
            }
            .buttonStyle(
                RoundedBorderedButton(
                    stroke: LinearGradient(colors: [.red, .orange, .purple], startPoint: .leading, endPoint: .trailing),
                    lineWidth: 4)
            )
            
            Spacer()
        }
        .padding()
    }
}

struct RoundedBorderedButton<S>: ButtonStyle where S: ShapeStyle {
    
    let stroke: S
    let lineWidth: CGFloat
    
    init(stroke: S = Color.blue, lineWidth: CGFloat = 1) {
        self.stroke = stroke
        self.lineWidth = lineWidth
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1 )
            .overlay(
                Capsule()
                    .stroke(stroke, lineWidth: lineWidth)
            )
            .clipShape(Capsule())
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyle()
    }
}
