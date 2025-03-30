//
//  ContentView.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authenticationManager: AuthenticationManager

    var body: some View {
        NavigationStack {
            if !authenticationManager.isAuthenticated {
                SignUp()
            }
        }
    }
}

#Preview {
    let manager = AuthenticationManager()
    ContentView()
        .environmentObject(manager)
}
