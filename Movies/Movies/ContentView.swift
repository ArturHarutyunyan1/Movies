//
//  ContentView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager

    var body: some View {
        ZStack {
            if authenticationManager.isLoading {
                ZStack {
                    Color.customBlue.ignoresSafeArea(.all)
                    ProgressView()
                        .tint(.white)
                        .frame(width: 50, height: 50)
                }
            } else {
                if authenticationManager.isAuthenticated {
                    if !authenticationManager.isEmailVerified {
                        Verification()
                    } else {
                        HomeView()
                    }
                } else {
                    AuthenticationView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationManager())
}
