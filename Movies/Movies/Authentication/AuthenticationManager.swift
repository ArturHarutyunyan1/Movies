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
    @Published var errorMessage: String = ""
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateListener = Auth.auth().addStateDidChangeListener {[weak self] _, user in
            DispatchQueue.main.async {
                guard let self = self else {return}
                
                self.user = user
                self.isAuthenticated = user != nil
                self.reloadState()
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                return
            }
            if let user = result?.user {
                self.user = user
                self.isAuthenticated = true
                self.isEmailVerified = user.isEmailVerified
                self.sendVerificationEmail(to: email)
                self.reloadState()
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                return
            }
            if let user = result?.user {
                self.user = user
                self.isAuthenticated = true
                self.isEmailVerified = user.isEmailVerified
                self.reloadState()
            }
        }
    }
    
    func reloadState() {
        guard let user = self.user else {return}
        
        user.reload {error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                return
            }
            self.isEmailVerified = user.isEmailVerified
        }
    }
    
    func sendVerificationEmail(to email: String) {
        guard let user = self.user else {return}
        
        user.sendEmailVerification {error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                return
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isAuthenticated = false
            self.isEmailVerified = false
        } catch {
            self.setErrorMessage(error: error.localizedDescription)
        }
    }
    
    private func setErrorMessage(error: String) {
        DispatchQueue.main.async {
            self.errorMessage = error
        }
    }
    
    deinit {
        if let authStateListener = authStateListener {
            Auth.auth().removeStateDidChangeListener(authStateListener)
        }
    }
}
