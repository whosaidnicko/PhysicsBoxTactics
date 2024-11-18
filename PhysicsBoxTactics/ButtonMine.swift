//
//  ButtonMine.swift
//  PhysicsBoxTactics
//
//  Created by Rawik Roupon on 18/11/2024.
//

import SwiftUI


struct ButtonMine: View {
    let text: String
    @State var size: CGFloat?
    var body: some View {
        RoundedRectangle(cornerRadius: 22)
            .fill(Color.init(hex: "#C0CC5E"))
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.init(hex: "#768129")
                        ,lineWidth: 6)
                
                Text(text)
                    .font(.system(size: size == nil ? 52 : size!, weight: .semibold))
                   
                    .foregroundStyle(Color.init(hex: "#8F9747"))
            }
            .frame(width: 242, height: 86)
            .shadow(color: Color.init(hex: "#768129"), radius: 3.82, x: 0, y: 3)
        
//
    }
}
