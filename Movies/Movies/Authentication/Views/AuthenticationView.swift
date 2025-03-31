//
//  AuthenticationView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

enum AppTab {
    case signup
    case signin
}

struct AuthenticationView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager
    @State private var isActive: Bool = false
    @State private var chosenTab: AppTab = .signup
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Image("BackgroundImage")
                    .resizable()
                    .scaledToFill()
            }
            .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    TabView(selection: $chosenTab) {
                        SignUpView(chosenTab: $chosenTab, geometry: geometry)
                            .tag(AppTab.signup)
                        SignInView(chosenTab: $chosenTab, geometry: geometry)
                            .tag(AppTab.signin)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeInOut(duration: 0.3), value: chosenTab)
                    .gesture(DragGesture().onChanged { _ in })
                    Spacer()
                    Button(action: {
                        isActive = true
                    }, label: {
                        Text("By continuing, you agree to our Terms of Service and Privacy Policy.")
                    })
                }
                .frame(width: geometry.size.width * 0.9)
                .foregroundStyle(.white)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $isActive) {
            WebView(url: URL(string: "https://app.websitepolicies.com/policies/view/h0wdod6c")!)
        }
    }
}
