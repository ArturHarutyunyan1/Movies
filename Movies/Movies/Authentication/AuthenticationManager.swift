//
//  AuthenticationManager.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthenticationManager : ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated: Bool = false
    @Published var isEmailVerified: Bool = false
}
