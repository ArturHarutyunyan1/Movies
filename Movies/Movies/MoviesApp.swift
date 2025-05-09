//
//  MoviesApp.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct MoviesApp: App {
    @StateObject var authenticationManager = AuthenticationManager()
    @StateObject var apiManager = ApiManager()
    @StateObject private var databaseManager = DatabaseManager()
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(authenticationManager)
                    .environmentObject(apiManager)
                    .environmentObject(databaseManager)
                    .preferredColorScheme(.dark)
                    .previewInterfaceOrientation(.portrait)
            }
        }
    }
}
