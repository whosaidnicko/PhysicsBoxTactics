//
//  MenuView.swift
//  PhysicsBoxTactics
//
//  Created by Rawik Roupon on 18/11/2024.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var navigationMng: NavigationMng
    @State var animationTurnOn: Bool = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            navigationMng.viewCh = .settings
                        }
                    } label: {
                        Image("setImg")
                    }
                    Spacer()
                    
                }
                Spacer()
                
                
                Spacer()
                
                Button {
                    withAnimation {
                        self.navigationMng.viewCh = .game
                    }
                } label: {
                    ButtonMine(text: "PLAY")
                }
            }
            .padding()
            
            Image("lokge")
                .scaleEffect(animationTurnOn ? 0.7 : 0.5)
                .rotationEffect(.degrees(animationTurnOn ? 360 : 0))
                .cornerRadius(animationTurnOn ? 100 : 0)
                .onAppear() {
                    withAnimation(Animation.bouncy(duration: 3).repeatForever()) {
                        animationTurnOn = true
                    }
                }
        }
    }
}
