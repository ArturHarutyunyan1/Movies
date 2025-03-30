//
//  MoviesApp.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject var authenticationManager = AuthenticationManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(authenticationManager)
                    .preferredColorScheme(.dark)
                    .previewInterfaceOrientation(.portrait)
            }
        }
    }
}
