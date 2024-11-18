//
//  SettingsView.swift
//  PhysicsBoxTactics
//
//  Created by Rawik Roupon on 18/11/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject private var navigationManager: NavigationMng
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        navigationManager.viewCh = .menu
                    }
                } label: {
                    Image("bkimg")
                }

                Spacer()
                
             
                
                Spacer()
                
                Image("bkimg")
                    .opacity(0)
            }
            
            VStack(spacing: 15) {
               

                
                Button {
                    if let url = URL(string: "https://www.dropbox.com/scl/fi/74w47lzlnu6v8prcsaxwa/Privacy-Policy-for-Physics-Box-Tactics.paper?rlkey=avcb5luauocdpfep6i6h2roko&st=6lzk9j2e&dl=0") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    ButtonMine(text: "Privacy", size: 35)
                }

                Button {
                    requestReview()
                } label: {
                    ButtonMine(text: "Rate", size: 35)
                }
            }
            .padding(.top, 80)
            
            Spacer()
        }
        .padding()
    }
}
