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
            if !authenticationManager.isAuthenticated {
                AuthenticationView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationManager())
}
