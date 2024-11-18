//
//  BoxJumpingView.swift
//  PhysicsBoxTactics
//
//  Created by Rawik Roupon on 18/11/2024.
//

import SwiftUI

struct BoxJumpingView: View {
    @State var showImage: Bool = true
    @State var animation: Bool = false
    @EnvironmentObject private var navigationManager: NavigationMng
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            navigationManager.viewCh = .menu
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.init(hex: "#C0CC5E"))
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.init(hex: "#768129")
                                        ,lineWidth: 6)
                                
                                Text("HOME")
                                    .font(.system(size: 20, weight: .semibold))
                                   
                                    .foregroundStyle(Color.init(hex: "#8F9747"))
                            }
                            .frame(width: 100, height: 40)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ZStack {
                    WKWebViewRepresentable(url: URL(string: "https://plays.org/game/physics-box-2/")!, onLoadCompletion: {
                        showImage = false
                        //            loadingFinished = true
                    })
                    
                    Image("lokge")
                        .scaleEffect(animation ? 0.7 : 0.5)
                        .rotationEffect(.degrees(animation ? 360 : 0))
                        .cornerRadius(animation ? 100 : 0)
                        .animation(Animation.bouncy(duration: 3.5).repeatForever(), value: animation )
                        .opacity(showImage ? 1 : 0)
                        .onAppear() {
                            animation = true
                        }
                }
            }
            .padding(.vertical)
        }
    }
}
