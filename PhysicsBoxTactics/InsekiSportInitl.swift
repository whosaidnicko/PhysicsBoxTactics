//
//  RutingView.swift
//  PhysicsBoxTactics
//
//  Created by Rawik Roupon on 18/11/2024.
//

import SwiftUI


struct InsekiSportInitl: View {
    @StateObject private var navigationMnG: NavigationMng = NavigationMng()
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .blur(radius: self.navigationMnG.viewCh == .loading ? 0 : 7)
                .ignoresSafeArea()
            
            VStack {
                Group {
                    switch navigationMnG.viewCh {
                    case .loading:
                        ZagrujaemView()
                    case .menu:
                        MenuView()
                    case .game:
                        BoxJumpingView()
                    case .settings:
                        SettingsView()
                    }
                }
                .transition(.scale)
            }
        }
        .environmentObject(navigationMnG)
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
import WebKit
struct WKWebViewRepresentable: UIViewRepresentable {

   typealias UIViewType = WKWebView
   var url: URL
   var webView: WKWebView
   var onLoadCompletion: (() -> Void)?

   init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
       self.url = url
       
       self.webView = webView
       self.webView.layer.opacity = 0
       self.onLoadCompletion = onLoadCompletion
   }

   func makeUIView(context: Context) -> WKWebView {
       webView.uiDelegate = context.coordinator
       webView.navigationDelegate = context.coordinator
       return webView
   }

   func updateUIView(_ uiView: UIViewType, context: Context) {
       let request = URLRequest(url: url)
       uiView.load(request)
       uiView.scrollView.isScrollEnabled = true
       uiView.scrollView.bounces = true
   }

   func makeCoordinator() -> Coordinator {
       Coordinator(self)
   }
}

extension WKWebViewRepresentable {

   final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
       var parent: WKWebViewRepresentable
       private var webViews: [WKWebView]

       init(_ parent: WKWebViewRepresentable) {
           self.parent = parent
           
           self.webViews = []
       }

       func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
           if navigationAction.targetFrame == nil {
               let popupWebView = WKWebView(frame: .zero, configuration: configuration)
               popupWebView.navigationDelegate = self
               popupWebView.uiDelegate = self

               parent.webView.addSubview(popupWebView)
               popupWebView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                   popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                   popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                   popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
               ])

               self.webViews.append(popupWebView)
               return popupWebView
           }
           return nil
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           // Notify when page loading has finished
           parent.onLoadCompletion?()
           webView.layer.opacity = 1
       }

       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           decisionHandler(.allow)
       }
   }

   func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
       return .all
   }
}
